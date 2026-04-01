-- 1. Tech Nodes
CREATE TABLE IF NOT EXISTS aether_tech_nodes (
    id          VARCHAR(64) PRIMARY KEY,
    name        VARCHAR(128) NOT NULL,
    description TEXT,
    category    VARCHAR(64) NOT NULL,
    node_type   VARCHAR(32) NOT NULL DEFAULT 'blueprint',
    target_ref  VARCHAR(128),
    tier        INT DEFAULT 1,
    research_cost INT DEFAULT 100,
    material_cost TEXT,
    money_cost  DOUBLE DEFAULT 0,
    icon        VARCHAR(256),
    data        TEXT,
    INDEX idx_tech_cat (category),
    INDEX idx_tech_tier (tier)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Tech Edges (DAG)
CREATE TABLE IF NOT EXISTS aether_tech_edges (
    parent_id   VARCHAR(64) NOT NULL,
    child_id    VARCHAR(64) NOT NULL,
    PRIMARY KEY (parent_id, child_id),
    FOREIGN KEY (parent_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE,
    FOREIGN KEY (child_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. Research Progress (Global)
CREATE TABLE IF NOT EXISTS aether_research_progress (
    account_id  VARCHAR(64) NOT NULL,
    node_id     VARCHAR(64) NOT NULL,
    progress    INT DEFAULT 0,
    status      VARCHAR(16) DEFAULT 'locked',
    started_at  BIGINT,
    completed_at BIGINT,
    PRIMARY KEY (account_id, node_id),
    INDEX idx_rp_status (account_id, status),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
