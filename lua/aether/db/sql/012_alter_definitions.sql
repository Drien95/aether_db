-- Migration 012: Add R&D fields to existing aether_definitions table
ALTER TABLE aether_definitions
    ADD COLUMN item_type VARCHAR(32) DEFAULT 'entity',
    ADD COLUMN max_upgrade_slots INT DEFAULT 0,
    ADD COLUMN requires_tech VARCHAR(64) DEFAULT NULL;

CREATE INDEX idx_def_type ON aether_definitions (item_type);
CREATE INDEX idx_def_tech ON aether_definitions (requires_tech);
