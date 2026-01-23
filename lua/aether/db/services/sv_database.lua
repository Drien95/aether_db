-- [[ AETHER CORE - DATABASE SERVICE ]]
-- Abstraction layer for SQL Operations (MySQLoo / SQLite)
-- Optimisé & Sécurisé

Aether.Database = Aether.Database or {}
Aether.Database.Queue = {}
Aether.Database.IsConnected = false
Aether.Database.IsProcessingQueue = false -- Flag pour éviter les doubles exécutions

-- [[ CONFIGURATION ]]
if file.Exists("aether/db/config/sv_config.lua", "LUA") then
    include("aether/db/config/sv_config.lua")
end

local DB_CONFIG = Aether.Config and Aether.Config.Database

-- [[ CONNECTION & KEEP-ALIVE ]]
function Aether.Database.Initialize()
    print("[AETHER] DEBUG: Initializing Database Service...")

    -- 0. Refresh Configuration
    if Aether.Config and Aether.Config.Database then
        DB_CONFIG = Aether.Config.Database
    end

    -- 1. Check Module
    if not mysqloo then
        local success, _ = pcall(require, "mysqloo")
        if not success then
            print("[AETHER] CRITICAL: MySQLoo module missing! Check lua/bin/.")
            return
        end
    end

    -- 2. Check Config
    if not DB_CONFIG then
        if file.Exists("aether/db/config/sv_config.lua", "LUA") then
            include("aether/db/config/sv_config.lua")
            DB_CONFIG = Aether.Config and Aether.Config.Database
        end
        if not DB_CONFIG then
            ErrorNoHalt("[AETHER] CRITICAL: DB_CONFIG is nil!")
            return
        end
    end

    -- 3. Connect
    if mysqloo then
        print("[AETHER] DEBUG: Target IP: " .. tostring(DB_CONFIG.host))
        print("[AETHER] DEBUG: DB Name:   " .. tostring(DB_CONFIG.database))

        print("[AETHER] Calling mysqloo.connect()...")
        Aether.Database.Obj = mysqloo.connect(DB_CONFIG.host, DB_CONFIG.username, DB_CONFIG.password, DB_CONFIG.database,
            DB_CONFIG.port)

        if Aether.Database.Obj then
            print("[AETHER] mysqloo object created: " .. tostring(Aether.Database.Obj))
            Aether.Database.Obj:setAutoReconnect(true)

            function Aether.Database.Obj:onConnected()
                print("[AETHER] Database Connected! (MySQLoo)")
                Aether.Database.IsConnected = true
                Aether.Database.Failures = 0
                Aether.Database.CircuitOpen = false
                Aether.Database.ProcessQueue()
                if Aether.Migration and Aether.Migration.Run then
                    Aether.Migration.Run()
                end
            end

            function Aether.Database.Obj:onConnectionFailed(err)
                print("[AETHER] !!! FATAL DB ERROR !!!")
                print("[AETHER] Connection Error: '" .. tostring(err) .. "'")
            end

            print("[AETHER] Calling Obj:connect()...")
            Aether.Database.Obj:connect()
        else
            print("[AETHER] CRITICAL: mysqloo.connect returned nil!")
        end
    end
end

-- [[ TRANSACTION SUPPORT (Performance) ]]
function Aether.Database.BeginTransaction()
    Aether.Database.Query("START TRANSACTION")
end

function Aether.Database.Commit()
    Aether.Database.Query("COMMIT")
end

function Aether.Database.Rollback()
    Aether.Database.Query("ROLLBACK")
end

-- [[ PREPARED STATEMENTS (Sécurisé) ]]
function Aether.Database.Prepare(sqlStr, params, callback, errorCallback)
    -- 1. Mode MySQLoo (Natif)
    if Aether.Database.Obj and Aether.Database.IsConnected then
        local stmt = Aether.Database.Obj:prepare(sqlStr)

        if type(params) == "table" then
            for i, v in ipairs(params) do
                local t = type(v)
                if t == "number" then
                    stmt:setNumber(i, v)
                elseif t == "boolean" then
                    stmt:setBoolean(i, v)
                else
                    stmt:setString(i, tostring(v))
                end
            end
        end

        function stmt:onSuccess(data)
            if callback then callback(data, stmt:lastInsert(), stmt:affectedRows()) end
        end

        function stmt:onError(err)
            print("[AETHER] Prepared SQL Error: " .. err)
            if errorCallback then errorCallback(err) end
        end

        stmt:start()

        -- 2. Mode Fallback (SQLite ou MySQLoo HS) - Sécurisé
    else
        local finalSQL = sqlStr

        -- Emulation des Prepared Statements pour éviter les Injections SQL
        if type(params) == "table" then
            for _, v in ipairs(params) do
                local safeVal = Aether.Database.Escape(v)

                -- Recherche la position du premier '?'
                -- 'true' dans string.find désactive les patterns Lua pour chercher le caractère littéral
                local startPos = string.find(finalSQL, "?", 1, true)

                if startPos then
                    -- Remplace le '?' par la valeur échappée
                    finalSQL = string.sub(finalSQL, 1, startPos - 1) .. safeVal .. string.sub(finalSQL, startPos + 1)
                end
            end
        end

        -- On envoie la requête construite au gestionnaire standard
        Aether.Database.Query(finalSQL, callback, errorCallback)
    end
end

-- [[ QUERY EXECUTION ]]
function Aether.Database.Query(queryStr, callback, errorCallback)
    -- Check Circuit Breaker
    if not Aether.Database.CheckCircuit() then
        if errorCallback then errorCallback("Circuit Breaker Open") end
        return
    end

    -- SQLite Fallback
    if not Aether.Database.Obj then
        local result = sql.Query(queryStr)
        if result == false then
            local err = sql.LastError()
            print("[AETHER] SQLite Error: " .. err .. " | Query: " .. queryStr)
            if errorCallback then errorCallback(err) end
        else
            if callback then callback(result) end
        end
        return
    end

    -- MySQLoo
    local q = Aether.Database.Obj:query(queryStr)

    function q:onSuccess(data)
        if callback then callback(data, q:lastInsert(), q:affectedRows()) end
    end

    function q:onError(err)
        print("[AETHER] SQL Error: " .. err .. " | Query: " .. queryStr)

        local errLower = string.lower(err)

        -- Détection améliorée des erreurs de connexion vs erreurs de syntaxe
        local isConnectionError = string.find(errLower, "lost connection") or
            string.find(errLower, "gone away") or
            string.find(errLower, "can't connect") or
            string.find(errLower, "refused")

        -- On ne coupe le circuit que si c'est une erreur de connexion
        -- Une erreur de syntaxe SQL ne doit pas passer le serveur en mode offline
        if isConnectionError then
            Aether.Database.TripCircuit()
        end

        if errorCallback then errorCallback(err) end
    end

    q:start()
end

-- [[ ESCAPING ]]
function Aether.Database.Escape(str)
    if str == nil then return "NULL" end

    -- Gestion des booléens
    if str == true then return "1" end
    if str == false then return "0" end
    if type(str) == "number" then return tostring(str) end

    if Aether.Database.Obj and Aether.Database.IsConnected then
        -- MySQLoo escape
        return "'" .. Aether.Database.Obj:escape(tostring(str)) .. "'"
    else
        -- SQLite escape (sql.SQLStr ajoute déjà les quotes)
        return sql.SQLStr(tostring(str))
    end
end

-- [[ QUEUE SYSTEM (Write-Behind) - Optimized ]]
function Aether.Database.AddToQueue(sqlStr)
    table.insert(Aether.Database.Queue, sqlStr)

    -- Si le processeur ne tourne pas, on le lance
    if not Aether.Database.IsProcessingQueue then
        Aether.Database.ProcessQueue()
    end
end

function Aether.Database.ProcessQueue()
    if not Aether.Database.IsConnected then return end

    -- Si la queue est vide, on arrête le processeur
    if #Aether.Database.Queue == 0 then
        Aether.Database.IsProcessingQueue = false
        return
    end

    Aether.Database.IsProcessingQueue = true
    local sqlStr = table.remove(Aether.Database.Queue, 1)

    Aether.Database.Query(sqlStr, function()
        Aether.Database.ProcessQueue()
    end, function(err)
        print("[AETHER] Queue Dropped Query: " .. err)
        Aether.Database.ProcessQueue()
    end)
end

timer.Create("Aether.Database.QueueWatchdog", 5, 0, function()
    if #Aether.Database.Queue > 0 and not Aether.Database.IsProcessingQueue then
        Aether.Database.ProcessQueue()
    end
end)

-- [[ CIRCUIT BREAKER ]]
Aether.Database.Failures = 0
Aether.Database.MaxFailures = 3
Aether.Database.CircuitOpen = false
Aether.Database.CircuitReset = 0

function Aether.Database.CheckCircuit()
    if Aether.Database.CircuitOpen then
        if CurTime() > Aether.Database.CircuitReset then
            print("[AETHER] Circuit Breaker: Half-Open test...")
            -- On tente une réinitialisation
            Aether.Database.CircuitOpen = false
            Aether.Database.Initialize() -- Tente de relancer la connexion
            return true
        end
        return false
    end
    return true
end

function Aether.Database.TripCircuit()
    Aether.Database.Failures = Aether.Database.Failures + 1
    if Aether.Database.Failures >= Aether.Database.MaxFailures then
        print("[AETHER] CRITICAL: DB Connection Lost! Circuit Breaker TRIPPED.")
        Aether.Database.CircuitOpen = true
        Aether.Database.IsConnected = false
        Aether.Database.Obj = nil
        Aether.Database.CircuitReset = CurTime() + 60
    end
end

print("[AETHER] Service Loaded: Database (Optimized)")

-- [[ INITIALIZATION HOOKS ]]
hook.Add("Initialize", "Aether.Database.Init", function()
    Aether.Database.Initialize()
end)

-- COMMANDES DEBUG
concommand.Add("aether_reload_db", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    print("[AETHER] Reloading Database System...")

    -- 1. Reload Config
    if file.Exists("aether/db/config/sv_config.lua", "LUA") then
        include("aether/db/config/sv_config.lua")
        print("[AETHER] Config Reloaded.")
    else
        print("[AETHER] ERROR: Config file missing!")
    end

    -- 2. Reload Migration Service
    if file.Exists("aether/db/services/sv_migration.lua", "LUA") then
        include("aether/db/services/sv_migration.lua")
        print("[AETHER] Migration Service Reloaded.")
    end

    -- 3. Reset Connection
    if Aether.Database.Obj and Aether.Database.IsConnected then
        print("[AETHER] Closing existing connection...")
        -- Aether.Database.Obj:disconnect() -- Not always available depending on version
        Aether.Database.Obj = nil
        Aether.Database.IsConnected = false
    end

    print("[AETHER] Resetting Circuit Breaker...")
    Aether.Database.CircuitOpen = false

    print("[AETHER] Calling Initialize()...")
    local success, err = pcall(Aether.Database.Initialize)
    if not success then
        print("[AETHER] CRITICAL ERROR during Initialize: " .. tostring(err))
    end
end)
