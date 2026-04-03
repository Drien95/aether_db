-- ============================================================================
-- Fichier: lua/aether/db/services/sv_seed.lua
-- Lance le seeding complet: vehicules aeriens, terrestres et armes.
-- Commande console: aether_seed_all
-- ============================================================================

local function Log(msg) print("[AETHER SEED] " .. msg) end

-- ============================================================================
-- PARSEUR SQL (adapte du service de migration)
-- ============================================================================

local function ParseSQL(content)
    if not content or string.Trim(content) == "" then return {} end

    -- Nettoyage
    content = string.gsub(content, "%-%-[^\n]*", "")   -- Retire commentaires --
    content = string.gsub(content, "[\r\n]+", " ")      -- Normalise fins de ligne
    content = string.gsub(content, "%s+", " ")           -- Normalise espaces

    local raw = string.Explode(";", content)
    local queries = {}

    for _, stmt in ipairs(raw) do
        stmt = string.Trim(stmt)
        if stmt ~= "" then
            table.insert(queries, stmt)
        end
    end

    return queries
end

-- ============================================================================
-- LECTEUR DE FICHIERS SQL
-- ============================================================================

local function ReadSeedFile(filename)
    local path = "aether/db/seeds/" .. filename
    local content = file.Read(path, "LUA")

    if not content then
        Log("ERREUR: Impossible de lire " .. filename)
        Log("  Essaye: aether/db/seeds/" .. filename)
        return nil
    end

    Log("Fichier lu: " .. filename .. " (" .. string.len(content) .. " octets)")
    return content
end

-- ============================================================================
-- EXECUTEUR SEQUENTIEL
-- ============================================================================

local function ExecuteQueries(queries, label, callback)
    local total = #queries
    local current = 0
    local errors = 0

    local function RunNext()
        current = current + 1
        if current > total then
            Log("  -> " .. label .. ": " .. (total - errors) .. "/" .. total .. " requetes OK" .. (errors > 0 and (" (" .. errors .. " erreurs)") or ""))
            if callback then callback() end
            return
        end

        Aether.Database.Query(queries[current], function()
            RunNext()
        end, function(err)
            errors = errors + 1
            Log("  ERREUR requete " .. current .. "/" .. total .. ": " .. string.sub(err, 1, 200))
            RunNext()
        end)
    end

    RunNext()
end

-- ============================================================================
-- EXECUTEUR D'UN FICHIER SEED
-- ============================================================================

local function RunSeedFile(filename, label, callback)
    local content = ReadSeedFile(filename)
    if not content then
        if callback then callback() end
        return
    end

    local queries = ParseSQL(content)
    Log(label .. ": " .. #queries .. " requetes a executer...")
    ExecuteQueries(queries, label, callback)
end

-- ============================================================================
-- VERIFICATION
-- ============================================================================

local function VerifySeed()
    Log("")
    Log("=== VERIFICATION ===")

    local checks = {
        {"Categories", "SELECT COUNT(*) as cnt FROM aether_categories"},
        {"Definitions (total)", "SELECT COUNT(*) as cnt FROM aether_definitions"},
        {"Definitions (vehicules)", "SELECT COUNT(*) as cnt FROM aether_definitions WHERE type = 'vehicle'"},
        {"Definitions (armes)", "SELECT COUNT(*) as cnt FROM aether_definitions WHERE type = 'weapon'"},
        {"Tech Nodes", "SELECT COUNT(*) as cnt FROM aether_tech_nodes"},
        {"Tech Edges", "SELECT COUNT(*) as cnt FROM aether_tech_edges"},
        {"Progression REPUBLIC", "SELECT COUNT(*) as cnt FROM aether_research_progress WHERE account_id = 'REPUBLIC'"},
    }

    local i = 0
    for _, check in ipairs(checks) do
        i = i + 1
        timer.Simple(i * 0.2, function()
            Aether.Database.Query(check[2], function(data)
                Log("  " .. check[1] .. ": " .. (data and data[1] and data[1].cnt or "?"))
            end, function(err)
                Log("  " .. check[1] .. ": ERREUR - " .. err)
            end)
        end)
    end
end

-- ============================================================================
-- COMMANDE PRINCIPALE
-- ============================================================================

concommand.Add("aether_seed_all", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then
        ply:ChatPrint("[AETHER] Permission refusee.")
        return
    end

    Log("=============================================")
    Log("=== LANCEMENT DU SEEDING COMPLET ===")
    Log("=============================================")
    Log("")
    Log("Fichiers:")
    Log("  1. seed_vehicles_aeriens.sql")
    Log("  2. seed_vehicles_terrestres.sql")
    Log("  3. seed_weapons.sql")
    Log("  4. seed_upgrades_vehicles.sql")
    Log("")

    -- Etape 1: Vehicules aeriens
    RunSeedFile("seed_vehicles_aeriens.sql", "Vehicules aeriens", function()
        Log("")

        -- Etape 2: Vehicules terrestres
        RunSeedFile("seed_vehicles_terrestres.sql", "Vehicules terrestres", function()
            Log("")

            -- Etape 3: Armes
            RunSeedFile("seed_weapons.sql", "Armes ARC9", function()
                Log("")

                -- Etape 4: Upgrades vehicules
                RunSeedFile("seed_upgrades_vehicles.sql", "Upgrades vehicules", function()
                    Log("")
                    Log("=============================================")
                    Log("=== SEEDING TERMINE ===")
                    Log("=============================================")

                    -- Verification
                    timer.Simple(1, function()
                        VerifySeed()

                    -- Recharger le tech tree si le service existe
                    timer.Simple(3, function()
                        if Aether.Research and Aether.Research.Services
                           and Aether.Research.Services.TechTree
                           and Aether.Research.Services.TechTree.Reload then
                            Log("")
                            Log("Rechargement du Tech Tree...")
                            Aether.Research.Services.TechTree.Reload()

                            if IsValid(ply) then
                                Aether.Research.Networking.SyncTree(ply)
                                Aether.Research.Networking.SyncProgress(ply)
                            end
                        end

                        if IsValid(ply) then
                            ply:ChatPrint("[AETHER] Seeding complet termine! Verifiez la console serveur.")
                        end
                    end)
                end)
                end)
            end)
        end)
    end)
end)

-- ============================================================================
-- COMMANDES INDIVIDUELLES
-- ============================================================================

concommand.Add("aether_seed_vehicles_air", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Log("Seed vehicules aeriens uniquement...")
    RunSeedFile("seed_vehicles_aeriens.sql", "Vehicules aeriens", function()
        Log("Termine.")
        if IsValid(ply) then ply:ChatPrint("[AETHER] Seed vehicules aeriens termine.") end
    end)
end)

concommand.Add("aether_seed_vehicles_ground", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Log("Seed vehicules terrestres uniquement...")
    RunSeedFile("seed_vehicles_terrestres.sql", "Vehicules terrestres", function()
        Log("Termine.")
        if IsValid(ply) then ply:ChatPrint("[AETHER] Seed vehicules terrestres termine.") end
    end)
end)

concommand.Add("aether_seed_weapons", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Log("Seed armes uniquement...")
    RunSeedFile("seed_weapons.sql", "Armes ARC9", function()
        Log("Termine.")
        if IsValid(ply) then ply:ChatPrint("[AETHER] Seed armes termine.") end
    end)
end)

concommand.Add("aether_seed_upgrades", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Log("Seed upgrades vehicules uniquement...")
    RunSeedFile("seed_upgrades_vehicles.sql", "Upgrades vehicules", function()
        Log("Termine.")
        if IsValid(ply) then ply:ChatPrint("[AETHER] Seed upgrades termine.") end
    end)
end)

-- ============================================================================
print("[AETHER R&D] Seed Service loaded. Commandes disponibles:")
print("  aether_seed_all              - Seed complet (vehicules + armes + upgrades)")
print("  aether_seed_vehicles_air     - Vehicules aeriens uniquement")
print("  aether_seed_vehicles_ground  - Vehicules terrestres uniquement")
print("  aether_seed_weapons          - Armes ARC9 uniquement")
print("  aether_seed_upgrades         - Upgrades vehicules uniquement")
