-- [[ AETHER CORE - MIGRATION SERVICE ]]
-- Schema management (Auto-Create Tables)

Aether.Migration = {}

local SCHEMA = {
    [[
    CREATE TABLE IF NOT EXISTS aether_accounts (
        id VARCHAR(64) PRIMARY KEY,
        balance BIGINT DEFAULT 0,
        type VARCHAR(32) NOT NULL,
        owner_id VARCHAR(64),
        last_updated INTEGER
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_transactions (
        id VARCHAR(64) PRIMARY KEY,
        timestamp INTEGER,
        sender_id VARCHAR(64),
        receiver_id VARCHAR(64),
        amount BIGINT,
        reason VARCHAR(255)
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_items (
        id VARCHAR(64) PRIMARY KEY,
        owner_id VARCHAR(64),
        class_id VARCHAR(64),
        data TEXT
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_logs (
        id VARCHAR(64) PRIMARY KEY,
        timestamp INTEGER,
        actor_id VARCHAR(64),
        message TEXT,
        type VARCHAR(32)
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_categories (
        id VARCHAR(32) PRIMARY KEY,
        name VARCHAR(64) NOT NULL,
        icon VARCHAR(64),
        parent_id VARCHAR(32)
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_definitions (
        class_id VARCHAR(64) PRIMARY KEY,
        name VARCHAR(64) NOT NULL,
        model VARCHAR(128) NOT NULL,
        type VARCHAR(32) DEFAULT 'item',
        weight DOUBLE DEFAULT 1.0,
        description TEXT,
        category_id VARCHAR(32) DEFAULT 'misc',
        width INTEGER DEFAULT 1,
        height INTEGER DEFAULT 1,
        amount INTEGER DEFAULT 1,
        is_buyable INTEGER DEFAULT 0,
        price BIGINT DEFAULT 0,
        data TEXT
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_logs_inventory (
        id VARCHAR(64) PRIMARY KEY,
        timestamp INTEGER,
        actor_id VARCHAR(64),
        action VARCHAR(16),
        class_id VARCHAR(64),
        quantity INTEGER,
        source VARCHAR(64)
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_logs_admin (
        id VARCHAR(64) PRIMARY KEY,
        timestamp INTEGER,
        actor_id VARCHAR(64),
        target_id VARCHAR(64),
        command VARCHAR(64),
        args TEXT
    )
    ]],
    [[
    CREATE TABLE IF NOT EXISTS aether_orgs (
        id VARCHAR(64) PRIMARY KEY,
        name VARCHAR(128) NOT NULL,
        roles_data TEXT,
        members_data TEXT,
        params TEXT
    )
    ]],
    [[
    ALTER TABLE aether_categories ADD COLUMN order_index INTEGER DEFAULT 99;
    ]],
    [[
    ALTER TABLE aether_orgs ADD COLUMN params TEXT;
    ]]
}

function Aether.Migration.Run()
    print("[AETHER] Running Migrations...")

    -- [[ CONFIGURATION ]]
    -- Path to migration files (relative to lua/)
    local MIGRATION_PATH = "aether/db/services/migrations/"
    -- Pattern to match migration files
    local MIGRATION_PATTERN = "sv_migration_v*.lua"
    -- [[ DYNAMIC DISCOVERY ]]
    local files, _ = file.Find(MIGRATION_PATH .. MIGRATION_PATTERN, "LUA")
    local migrations = {}

    for _, filename in ipairs(files) do
        -- Extract Version Number (e.g. sv_migration_v5.lua -> 5)
        local ver = tonumber(string.match(filename, "v(%d+)"))
        if ver then
            table.insert(migrations, { version = ver, path = MIGRATION_PATH .. filename })
        end
    end

    -- Sort by Version
    table.sort(migrations, function(a, b) return a.version < b.version end)

    -- Load & Run
    for _, mig in ipairs(migrations) do
        -- Load file
        include(mig.path)
        print("[AETHER] Migration Loaded: V" .. mig.version)
    end

    local function RunMigrations()
        print("[AETHER] Executing Versioned Migrations...")
        for _, mig in ipairs(migrations) do
            local key = "V" .. mig.version
            if Aether.Migration[key] then
                -- Execute
                Aether.Migration[key]()
                -- print("[AETHER] Applied Migration V" .. mig.version)
            end
        end
        hook.Run("Aether.Database.Ready")
    end

    -- Modify RunNext to finish with Migrations
    local oldRunNext = RunNext
    RunNext = function(index)
        if index > #SCHEMA then
            print("[AETHER] V1 Schema Check Completed.")
            RunMigrations()
            return
        end

        -- Original Logic
        local query = SCHEMA[index]
        Aether.Database.Query(query, function()
            RunNext(index + 1)
        end, function(err)
            -- Ignore duplicates
            local errLower = string.lower(err)
            if not (string.find(errLower, "duplicate column") or string.find(errLower, "already exists")) then
                print("[AETHER] CRITICAL: Migration " .. index .. " Failed: " .. err)
            end
            RunNext(index + 1)
        end)
    end

    RunNext(1)
end

concommand.Add("aether_fix_db", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsSuperAdmin() then return end
    print("[AETHER] Forcing Schema Update (params)...")
    Aether.Database.Query("ALTER TABLE aether_orgs ADD COLUMN params TEXT;", function()
        print("[AETHER] SUCCESS: Added params column to aether_orgs.")
    end, function(err)
        print("[AETHER] NOTE: " .. err)
    end)
    -- Also ensure categories has order_index
    Aether.Database.Query("ALTER TABLE aether_categories ADD COLUMN order_index INTEGER DEFAULT 99;", function()
        print("[AETHER] SUCCESS: Added order_index to aether_categories.")
    end)
end)

print("[AETHER] Service Loaded: Migration")
