-- [[ AETHER PLAYERS - ADD JOB COLUMN ]]
-- Stores the DarkRP job command name per character for persistence across sessions
-- Format: command string (e.g., "citizen", "cp")

ALTER TABLE aether_players
ADD COLUMN job VARCHAR(64) DEFAULT '' COMMENT 'DarkRP job command name';
