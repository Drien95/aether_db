-- [[ AETHER DATABASE - INITIALIZATION ]]
Aether = Aether or {}

-- Initialize Config & Database Stack
local function LoadAetherDB()
    print("[AETHER] Loading Internal Database Module...")

    -- Use fixed absolute paths relative to LUA root? Or relative includes?
    -- include("aether/db/...")

    -- 1. Config
    if file.Exists("aether/db/config/sv_config.lua", "LUA") then
        include("aether/db/config/sv_config.lua")
    else
        print("[AETHER] WARNING: Database Config Missing! (aether/db/config/sv_config.lua)")
    end

    -- 2. Services (Database & Migrations)
    if SERVER then
        include("aether/db/services/sv_database.lua")
        include("aether/db/services/sv_migration.lua")
    end
end

LoadAetherDB()
