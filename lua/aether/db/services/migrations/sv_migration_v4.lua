-- [[ AETHER MIGRATION V4 ]]
-- Updates definitions table with missing fields

Aether.Migration = Aether.Migration or {}

function Aether.Migration.V4()
    print("[AETHER] Running Migration V4...")

    local updates = {
        "ALTER TABLE aether_definitions ADD COLUMN category_id VARCHAR(32) DEFAULT 'misc';",
        "ALTER TABLE aether_definitions ADD COLUMN description TEXT;",
        "ALTER TABLE aether_definitions ADD COLUMN amount INTEGER DEFAULT 1;",
        "ALTER TABLE aether_definitions ADD COLUMN is_buyable INTEGER DEFAULT 0;",
        "ALTER TABLE aether_definitions ADD COLUMN price BIGINT DEFAULT 0;",
        "ALTER TABLE aether_definitions ADD COLUMN width INTEGER DEFAULT 1;",
        "ALTER TABLE aether_definitions ADD COLUMN height INTEGER DEFAULT 1;",
        "ALTER TABLE aether_definitions ADD COLUMN materials TEXT;"
        --"ALTER TABLE aether_definitions ADD COLUMN item_type VARCHAR(32) DEFAULT 'item';" -- Might exist as 'type'
    }

    local function RunUpdate(index)
        if index > #updates then
            print("[AETHER] Migration V4 Completed.")
            return
        end

        Aether.Database.Query(updates[index], function()
            RunUpdate(index + 1)
        end, function(err)
            -- Ignore duplicate column errors
            if not (string.find(err, "duplicate column") or string.find(err, "already exists")) then
                print("[AETHER] Migration V4 Error: " .. err)
            end
            RunUpdate(index + 1)
        end)
    end

    RunUpdate(1)
end
