-- [[ AETHER CORE - MIGRATION V3 ]]
-- Purpose: Schema Fix - Add missing 'description' column
-- Changes:
-- - ADD COLUMN description (TEXT)

Aether.Migration = Aether.Migration or {}

function Aether.Migration.V3()
    print("[AETHER] Running Migration V3: Add Description Column...")

    local queries = {
        "ALTER TABLE aether_definitions ADD COLUMN description TEXT;"
    }

    local pending = #queries

    for _, sql in ipairs(queries) do
        Aether.Database.Query(sql, function()
            print("[AETHER] Migration V3: Executed -> " .. sql)
            pending = pending - 1
            if pending == 0 then
                print("[AETHER] Migration V3: COMPLETE!")
            end
        end, function(err)
            -- Ignore specific errors like "Duplicate column" if re-running
            if string.find(err, "Duplicate column") or string.find(err, "jobs_data") then
                -- benign
                print("[AETHER] Migration V3: Column already exists (Skipping).")
                pending = pending - 1
            else
                print("[AETHER] Migration V3 ERROR: " .. err)
            end
        end)
    end
end
