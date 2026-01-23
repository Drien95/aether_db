-- [[ AETHER PLAYERS - MULTI-ACCOUNT SYSTEM ]]
-- Maps players (SteamID) to their character accounts (UUID)
-- A single player can have multiple character accounts
-- Each account has its own name, inventory, and organization memberships   
CREATE TABLE IF NOT EXISTS aether_players (
    steam_id VARCHAR(64) NOT NULL,           -- Player's SteamID64 (real person)
    uuid VARCHAR(64) PRIMARY KEY,            -- Character account UUID (unique per character)
    name VARCHAR(128),                       -- Character name
    last_seen BIGINT,
    
    INDEX idx_player_steam (steam_id),
    FOREIGN KEY (uuid) REFERENCES aether_accounts(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
