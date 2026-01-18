-- [[ AETHER CORE - MIGRATION V2 ]]
-- Purpose: Schema Upgrade for C4T Integration and Definitions Refactor
-- Changes:
-- - ADD COLUMN category_id (VARCHAR 50)
-- - ADD COLUMN width (INT)
-- - ADD COLUMN height (INT)
-- - ADD COLUMN item_type (VARCHAR 50)

Aether.Migration = Aether.Migration or {}

function Aether.Migration.V2()
    print("[AETHER] Running Migration V2: Schema Upgrade...")

    local queries = {
        "ALTER TABLE aether_definitions ADD COLUMN category_id VARCHAR(50) DEFAULT 'misc';",
        "ALTER TABLE aether_definitions ADD COLUMN width INTEGER DEFAULT 1;",
        "ALTER TABLE aether_definitions ADD COLUMN height INTEGER DEFAULT 1;",
        "ALTER TABLE aether_definitions ADD COLUMN item_type VARCHAR(50) DEFAULT 'entity';"
    }

    local pending = #queries

    for _, sql in ipairs(queries) do
        Aether.Database.Query(sql, function()
            print("[AETHER] Migration V2: Executed -> " .. sql)
            pending = pending - 1
            if pending == 0 then
                print("[AETHER] Migration V2: COMPLETE!")
            end
        end, function(err)
            -- Ignore specific errors like "Duplicate column" if re-running
            if string.find(err, "Duplicate column") then
                print("[AETHER] Migration V2: Column already exists (Skipping).")
                pending = pending - 1
            else
                print("[AETHER] Migration V2 ERROR: " .. err)
            end
        end)
    end
end
