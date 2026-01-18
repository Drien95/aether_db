-- [[ AETHER MIGRATION V5 ]]
-- Creates aether_chests table for storage.

Aether.Migration = Aether.Migration or {}

function Aether.Migration.V5()
    print("[AETHER] Running Migration V5: Create Chest Table...")

    -- Schema:
    -- steamid: VARCHAR(20) / BIGINT - SteamID64
    -- items: LONGTEXT - JSON Content
    -- last_update: BIGINT - Timestamp

    local queries = {
        [[
            CREATE TABLE IF NOT EXISTS aether_chests (
                steamid VARCHAR(20) NOT NULL PRIMARY KEY,
                items LONGTEXT,
                last_update BIGINT DEFAULT 0
            );
        ]]
    }

    local function RunUpdate(index)
        if index > #queries then
            print("[AETHER] Migration V5 Completed.")
            return
        end

        Aether.Database.Query(queries[index], function()
            RunUpdate(index + 1)
        end, function(err)
            print("[AETHER] Migration V5 Error: " .. err)
            RunUpdate(index + 1)
        end)
    end

    RunUpdate(1)
end

concommand.Add("aether_run_migration_v5", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Aether.Migration.V5()
end)
