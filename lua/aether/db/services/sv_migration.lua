-- [[ AETHER CORE - MIGRATION SERVICE (Standard SQL) ]]
Aether.Migration = {}

-- 1. Table de suivi
local function EnsureVersionTable(callback)
    local sql = [[
        CREATE TABLE IF NOT EXISTS aether_schema_migrations (
            version INT PRIMARY KEY,
            filename VARCHAR(255),
            applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
    ]]

    Aether.Database.Query(sql, function()
        if callback then callback() end
    end, function(err)
        print("[AETHER] CRITICAL: Failed to create migration table: " .. err)
        if callback then callback() end
    end)
end

-- 2. Lecture des fichiers SQL
local function GetMigrationFiles()
    local files, _ = file.Find("aether/db/sql/*.sql", "LUA")
    local migrations = {}

    for _, f in ipairs(files) do
        local ver = tonumber(string.match(f, "^(%d+)"))
        if ver then
            table.insert(migrations, { version = ver, file = "aether/db/sql/" .. f, name = f })
        end
    end

    table.SortByMember(migrations, "version", true)
    return migrations
end

-- 3. Parser SQL (Nettoyage + Split)
local function LoadSQLContent(path)
    if not file.Exists(path, "LUA") then return {} end

    local content = file.Read(path, "LUA")
    if not content or string.Trim(content) == "" then return {} end

    -- Nettoyage
    content = string.gsub(content, "%-%-[^\n]*", "") -- Remove Comments
    content = string.gsub(content, "[\r\n]+", " ")   -- Normalize EOL
    content = string.gsub(content, "%s+", " ")       -- Normalize Spaces

    local raw_statements = string.Explode(";", content)
    local queries = {}
    local isMySQL = (Aether.Database.Obj ~= nil)

    for _, stmt in ipairs(raw_statements) do
        stmt = string.Trim(stmt)
        if stmt ~= "" then
            -- Transpilation automatique (SQLite Compatibility layer)
            if not isMySQL then
                stmt = string.gsub(stmt, "CHARACTER SET [%w_]+", "")
                stmt = string.gsub(stmt, "COLLATE [%w_]+", "")
                stmt = string.gsub(stmt, "ENGINE=[%w_]+", "")

                stmt = string.gsub(stmt, "MEDIUMTEXT", "TEXT")
                stmt = string.gsub(stmt, "INT ", "INTEGER ")
                stmt = string.gsub(stmt, "TINYINT", "INTEGER")

                local tableName = string.match(stmt, "CREATE TABLE IF NOT EXISTS ([%w_]+)")
                if tableName then
                    for idxName, cols in string.gmatch(stmt, "INDEX ([%w_]+) %(([^)]+)%)") do
                        table.insert(queries,
                            string.format("CREATE INDEX IF NOT EXISTS %s ON %s (%s)", idxName, tableName, cols))
                    end
                    stmt = string.gsub(stmt, ",%s*INDEX [%w_]+ %([^)]+%)", "")
                end
            end
            table.insert(queries, stmt)
        end
    end
    return queries
end

-- 4. Exécution
function Aether.Migration.Run()
    print("[AETHER] Starting Migration Process (Standard SQL)...")

    EnsureVersionTable(function()
        Aether.Database.Query("SELECT MAX(version) as current_ver FROM aether_schema_migrations", function(data)
            local currentVer = 0
            if data and data[1] and data[1].current_ver then
                currentVer = tonumber(data[1].current_ver) or 0
            end

            print("[AETHER] DB Current Version: " .. currentVer)

            local allMigrations = GetMigrationFiles()
            local pending = {}

            for _, m in ipairs(allMigrations) do
                if m.version > currentVer then
                    table.insert(pending, m)
                end
            end

            if #pending == 0 then
                print("[AETHER] DB is up to date.")
                hook.Run("Aether.Database.Ready")
                return
            end

            print("[AETHER] Found " .. #pending .. " pending migrations...")

            local function ApplyNext(index)
                if index > #pending then
                    print("[AETHER] All migrations applied successfully!")
                    hook.Run("Aether.Database.Ready")
                    return
                end

                local m = pending[index]
                print("[AETHER] Applying migration " .. m.version .. ": " .. m.name)

                local queries = LoadSQLContent(m.file)
                if #queries == 0 then
                    -- Empty file? Mark as done anyway
                    local logSql = "INSERT INTO aether_schema_migrations (version, filename) VALUES (" ..
                    m.version .. ", '" .. m.name .. "')"
                    Aether.Database.Query(logSql, function() ApplyNext(index + 1) end)
                    return
                end

                local qIndex = 1
                local function RunFileQueries()
                    if qIndex > #queries then
                        local logSql = "INSERT INTO aether_schema_migrations (version, filename) VALUES (" ..
                        m.version .. ", '" .. m.name .. "')"
                        Aether.Database.Query(logSql, function() ApplyNext(index + 1) end)
                        return
                    end

                    local q = queries[qIndex]
                    Aether.Database.Query(q, function()
                        qIndex = qIndex + 1
                        RunFileQueries()
                    end, function(err)
                        ErrorNoHalt("[AETHER] MIGRATION ERROR in " .. m.name .. ": " .. err)
                        -- Halt? Or try next? Usually halt.
                    end)
                end

                RunFileQueries()
            end

            ApplyNext(1)
        end, function(err)
            print("[AETHER] CRITICAL ERROR fetching version: " .. err)
        end)
    end)
end

print("[AETHER] Service Loaded: Migration (Standard SQL)")
