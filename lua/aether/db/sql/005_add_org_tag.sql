-- [[ AETHER ORGANIZATIONS - ADD TAG FIELD ]]
-- Adds the 'tag' field to aether_orgs table for display names
-- Format: [TAG] RANK BADGE Name
-- Example: [212th] SGT 8888 Height

ALTER TABLE aether_orgs 
ADD COLUMN tag VARCHAR(16) COMMENT 'Organization tag for display names (e.g., "212th", "UNNA")';
