-- [[ AETHER MIGRATION V6 ]]
-- Adds 'materials' column to aether_accounts.

Aether.Migration = Aether.Migration or {}

function Aether.Migration.V6()
    print("[AETHER] Running Migration V6: Add Materials Column...")

    local queries = {
        "ALTER TABLE aether_accounts ADD COLUMN materials LONGTEXT DEFAULT '{}';"
    }

    local function RunUpdate(index)
        if index > #queries then
            print("[AETHER] Migration V6 Completed.")
            return
        end

        Aether.Database.Query(queries[index], function()
            RunUpdate(index + 1)
        end, function(err)
            -- Ignore "Duplicate column" error if re-running
            if err and string.find(string.lower(err), "duplicate") then
                print("[AETHER] Migration V6 Info: Column likely exists.")
            else
                print("[AETHER] Migration V6 Error: " .. err)
            end
            RunUpdate(index + 1)
        end)
    end

    RunUpdate(1)
end

concommand.Add("aether_run_migration_v6", function(ply)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    Aether.Migration.V6()
end)
