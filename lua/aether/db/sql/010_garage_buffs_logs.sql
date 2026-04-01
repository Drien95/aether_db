-- 1. Garage Vehicles
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

-- 2. Active Passive Buffs
CREATE TABLE IF NOT EXISTS aether_active_buffs (
    id          VARCHAR(64) PRIMARY KEY,
    account_id  VARCHAR(64) NOT NULL,
    node_id     VARCHAR(64) NOT NULL,
    buff_key    VARCHAR(64) NOT NULL,
    buff_value  TEXT NOT NULL,
    scope       VARCHAR(32) DEFAULT 'character',
    expires_at  BIGINT,
    INDEX idx_buff_account (account_id),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Research Logs (Audit Trail)
CREATE TABLE IF NOT EXISTS aether_logs_research (
    id          VARCHAR(64) PRIMARY KEY,
    timestamp   BIGINT NOT NULL,
    actor_id    VARCHAR(64) NOT NULL,
    action      VARCHAR(32) NOT NULL,
    node_id     VARCHAR(64),
    upgrade_id  VARCHAR(64),
    item_uuid   VARCHAR(64),
    details     TEXT,
    INDEX idx_rlog_actor (actor_id),
    INDEX idx_rlog_time (timestamp)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
