-- [[ AETHER PLAYER SESSIONS ]]
-- Tracks which character account each connected player is currently using
-- Allows persistence of account selection across reconnects
CREATE TABLE IF NOT EXISTS aether_player_sessions (
    steam_id VARCHAR(64) PRIMARY KEY,        -- Player's SteamID64
    active_uuid VARCHAR(64),                 -- Currently selected character account UUID
    last_updated BIGINT,
    
    FOREIGN KEY (active_uuid) REFERENCES aether_accounts(id) ON DELETE SET NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
