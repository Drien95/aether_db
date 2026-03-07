-- Migration 008: Add faction support to character system
-- Adds faction column to aether_players table for Clone/Jedi/État-Major factions
-- Also adds indexes for performance (faction queries and badge uniqueness checks)

-- Add faction column to aether_players table
ALTER TABLE aether_players
ADD COLUMN faction VARCHAR(32) DEFAULT NULL;

-- Add index for faction queries (filtering by faction)
CREATE INDEX idx_player_faction ON aether_players(faction);

-- Add index for badge uniqueness checks (Clone matricule validation)
CREATE INDEX idx_player_badge ON aether_players(badge);
