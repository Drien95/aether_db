-- ============================================================================
-- Migration 023 : Tables R&D (aether_research)
-- Consolide les migrations 008-015 qui étaient dans aether_research avec des
-- numéros inférieurs à la version actuelle (022) → jamais appliquées.
-- Toutes les CREATE TABLE utilisent IF NOT EXISTS (idempotent).
-- ============================================================================

-- 1. Tech Nodes (arbre de recherche)
CREATE TABLE IF NOT EXISTS aether_tech_nodes (
    id            VARCHAR(64) PRIMARY KEY,
    name          VARCHAR(128) NOT NULL,
    description   TEXT,
    category      VARCHAR(64) NOT NULL,
    node_type     VARCHAR(32) NOT NULL DEFAULT 'blueprint',
    target_ref    VARCHAR(128),
    tier          INT DEFAULT 1,
    research_cost INT DEFAULT 100,
    material_cost TEXT,
    money_cost    DOUBLE DEFAULT 0,
    icon          VARCHAR(256),
    data          TEXT,
    INDEX idx_tech_cat (category),
    INDEX idx_tech_tier (tier)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Tech Edges (DAG de dépendances)
CREATE TABLE IF NOT EXISTS aether_tech_edges (
    parent_id VARCHAR(64) NOT NULL,
    child_id  VARCHAR(64) NOT NULL,
    PRIMARY KEY (parent_id, child_id),
    FOREIGN KEY (parent_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE,
    FOREIGN KEY (child_id)  REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Research Progress
CREATE TABLE IF NOT EXISTS aether_research_progress (
    account_id   VARCHAR(64) NOT NULL,
    node_id      VARCHAR(64) NOT NULL,
    progress     INT DEFAULT 0,
    status       VARCHAR(16) DEFAULT 'locked',
    started_at   BIGINT,
    completed_at BIGINT,
    PRIMARY KEY (account_id, node_id),
    INDEX idx_rp_status (account_id, status),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 4. Upgrades (avec colonne data incluse dès le départ)
CREATE TABLE IF NOT EXISTS aether_upgrades (
    id           VARCHAR(64) PRIMARY KEY,
    name         VARCHAR(128) NOT NULL,
    description  TEXT,
    category     VARCHAR(64) NOT NULL,
    target_type  VARCHAR(32) NOT NULL,
    effect_type  VARCHAR(32) NOT NULL,
    effect_key   VARCHAR(64) NOT NULL,
    effect_value TEXT NOT NULL,
    stackable    TINYINT DEFAULT 0,
    conflicts    TEXT,
    money_cost   DOUBLE DEFAULT 0,
    material_cost TEXT,
    icon         VARCHAR(256),
    data         TEXT,
    INDEX idx_upg_cat (category),
    INDEX idx_upg_target (target_type)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 5. Upgrade Slots
CREATE TABLE IF NOT EXISTS aether_upgrade_slots (
    definition_id VARCHAR(64) NOT NULL,
    upgrade_id    VARCHAR(64) NOT NULL,
    slot_index    INT DEFAULT 0,
    is_default    TINYINT DEFAULT 0,
    PRIMARY KEY (definition_id, upgrade_id),
    FOREIGN KEY (upgrade_id) REFERENCES aether_upgrades(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 6. Applied Upgrades (par item)
CREATE TABLE IF NOT EXISTS aether_item_upgrades (
    item_uuid  VARCHAR(64) NOT NULL,
    upgrade_id VARCHAR(64) NOT NULL,
    applied_at BIGINT NOT NULL,
    applied_by VARCHAR(64),
    PRIMARY KEY (item_uuid, upgrade_id),
    FOREIGN KEY (upgrade_id) REFERENCES aether_upgrades(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 7. Garage Vehicles
CREATE TABLE IF NOT EXISTS aether_garage (
    uuid          VARCHAR(64) PRIMARY KEY,
    definition_id VARCHAR(64) NOT NULL,
    owner_id      VARCHAR(64) NOT NULL,
    slot_index    INT DEFAULT 0,
    nickname      VARCHAR(64),
    condition_pct DOUBLE DEFAULT 100.0,
    is_deployed   TINYINT DEFAULT 0,
    deployed_by   VARCHAR(64),
    data          TEXT,
    created_at    BIGINT NOT NULL,
    last_used     BIGINT,
    INDEX idx_garage_owner (owner_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 8. Active Passive Buffs
CREATE TABLE IF NOT EXISTS aether_active_buffs (
    id         VARCHAR(64) PRIMARY KEY,
    account_id VARCHAR(64) NOT NULL,
    node_id    VARCHAR(64) NOT NULL,
    buff_key   VARCHAR(64) NOT NULL,
    buff_value TEXT NOT NULL,
    scope      VARCHAR(32) DEFAULT 'character',
    expires_at BIGINT,
    INDEX idx_buff_account (account_id),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 9. Research Logs
CREATE TABLE IF NOT EXISTS aether_logs_research (
    id         VARCHAR(64) PRIMARY KEY,
    timestamp  BIGINT NOT NULL,
    actor_id   VARCHAR(64) NOT NULL,
    action     VARCHAR(32) NOT NULL,
    node_id    VARCHAR(64),
    upgrade_id VARCHAR(64),
    item_uuid  VARCHAR(64),
    details    TEXT,
    INDEX idx_rlog_actor (actor_id),
    INDEX idx_rlog_time  (timestamp)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 10. Commissions
CREATE TABLE IF NOT EXISTS aether_commissions (
    id           VARCHAR(64) PRIMARY KEY,
    node_id      VARCHAR(64) NOT NULL,
    requester_id VARCHAR(64) NOT NULL,
    status       VARCHAR(16) DEFAULT 'pending',
    escrow_money DOUBLE DEFAULT 0,
    escrow_mats  TEXT,
    accepted_by  VARCHAR(64),
    research_id  VARCHAR(64),
    notes        TEXT,
    created_at   BIGINT NOT NULL,
    updated_at   BIGINT,
    INDEX idx_comm_status    (status),
    INDEX idx_comm_requester (requester_id),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 11. Research Contributions
CREATE TABLE IF NOT EXISTS aether_research_contributions (
    id          VARCHAR(64) PRIMARY KEY,
    node_id     VARCHAR(64) NOT NULL,
    player_uuid VARCHAR(64) NOT NULL,
    points      INT NOT NULL,
    source      VARCHAR(32) NOT NULL,
    created_at  BIGINT NOT NULL,
    INDEX idx_contrib_node   (node_id),
    INDEX idx_contrib_player (player_uuid),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 12. Active Upgrades (PRIMARY KEY corrigée d'emblée = pas besoin du fix 015)
CREATE TABLE IF NOT EXISTS aether_active_upgrades (
    account_id    VARCHAR(64) NOT NULL,
    upgrade_id    VARCHAR(64) NOT NULL,
    vehicle_class VARCHAR(64) NOT NULL,
    activated_at  BIGINT NOT NULL,
    activated_by  VARCHAR(64),
    cost_money    DOUBLE DEFAULT 0,
    cost_materials TEXT,
    PRIMARY KEY (account_id, upgrade_id, vehicle_class),
    INDEX idx_active_vehicle (vehicle_class),
    INDEX idx_active_account (account_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 13. Ajout des colonnes R&D à aether_definitions (IF NOT EXISTS = MariaDB 10.1+)
ALTER TABLE aether_definitions
    ADD COLUMN IF NOT EXISTS item_type         VARCHAR(32) DEFAULT 'entity',
    ADD COLUMN IF NOT EXISTS max_upgrade_slots INT DEFAULT 0,
    ADD COLUMN IF NOT EXISTS requires_tech     VARCHAR(64) DEFAULT NULL;
