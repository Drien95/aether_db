-- [[ AETHER PLAYERS - ADD BADGE/MATRICULE ]]\r
-- Adds the 'badge' field to aether_players table for character identification\r
-- Format: BADGE Name\r
-- Example: 8888 Height\r

ALTER TABLE aether_players
ADD COLUMN badge VARCHAR(16) COMMENT 'Character badge/matricule number (e.g., "8888")';
