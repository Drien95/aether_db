-- 1. Upgrade Definitions
CREATE TABLE IF NOT EXISTS aether_upgrades (
    id          VARCHAR(64) PRIMARY KEY,
    name        VARCHAR(128) NOT NULL,
    description TEXT,
    category    VARCHAR(64) NOT NULL,
    target_type VARCHAR(32) NOT NULL,
    effect_type VARCHAR(32) NOT NULL,
    effect_key  VARCHAR(64) NOT NULL,
    effect_value TEXT NOT NULL,
    stackable   TINYINT DEFAULT 0,
    conflicts   TEXT,
    money_cost  DOUBLE DEFAULT 0,
    material_cost TEXT,
    icon        VARCHAR(256),
    INDEX idx_upg_cat (category),
    INDEX idx_upg_target (target_type)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Allowed Upgrade Slots
CREATE TABLE IF NOT EXISTS aether_upgrade_slots (
    definition_id VARCHAR(64) NOT NULL,
    upgrade_id    VARCHAR(64) NOT NULL,
    slot_index    INT DEFAULT 0,
    is_default    TINYINT DEFAULT 0,
    PRIMARY KEY (definition_id, upgrade_id),
    FOREIGN KEY (upgrade_id) REFERENCES aether_upgrades(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Applied Upgrades
CREATE TABLE IF NOT EXISTS aether_item_upgrades (
    item_uuid   VARCHAR(64) NOT NULL,
    upgrade_id  VARCHAR(64) NOT NULL,
    applied_at  BIGINT NOT NULL,
    applied_by  VARCHAR(64),
    PRIMARY KEY (item_uuid, upgrade_id),
    FOREIGN KEY (upgrade_id) REFERENCES aether_upgrades(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
