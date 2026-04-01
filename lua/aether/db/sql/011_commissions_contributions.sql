-- 1. Commissions (Escrow)
CREATE TABLE IF NOT EXISTS aether_commissions (
    id              VARCHAR(64) PRIMARY KEY,
    node_id         VARCHAR(64) NOT NULL,
    requester_id    VARCHAR(64) NOT NULL,
    status          VARCHAR(16) DEFAULT 'pending',
    escrow_money    DOUBLE DEFAULT 0,
    escrow_mats     TEXT,
    accepted_by     VARCHAR(64),
    research_id     VARCHAR(64),
    notes           TEXT,
    created_at      BIGINT NOT NULL,
    updated_at      BIGINT,
    INDEX idx_comm_status (status),
    INDEX idx_comm_requester (requester_id),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Individual Contributions
CREATE TABLE IF NOT EXISTS aether_research_contributions (
    id          VARCHAR(64) PRIMARY KEY,
    node_id     VARCHAR(64) NOT NULL,
    player_uuid VARCHAR(64) NOT NULL,
    points      INT NOT NULL,
    source      VARCHAR(32) NOT NULL,
    created_at  BIGINT NOT NULL,
    INDEX idx_contrib_node (node_id),
    INDEX idx_contrib_player (player_uuid),
    FOREIGN KEY (node_id) REFERENCES aether_tech_nodes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
