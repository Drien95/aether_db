CREATE TABLE IF NOT EXISTS aether_active_upgrades (
    account_id VARCHAR(64) NOT NULL,             -- "REPUBLIC" (global)
    upgrade_id VARCHAR(64) NOT NULL,             -- "tx130_t1_hp"
    vehicle_class VARCHAR(64) NOT NULL,          -- "lvs_tx130_t"
    activated_at BIGINT NOT NULL,                -- Timestamp activation
    activated_by VARCHAR(64),                    -- UUID du joueur qui a activé
    cost_money DOUBLE DEFAULT 0,                 -- Coût payé (audit)
    cost_materials TEXT,                         -- JSON matériaux payés (audit)
    PRIMARY KEY (account_id, upgrade_id, vehicle_class),
    INDEX idx_active_vehicle (vehicle_class),
    INDEX idx_active_account (account_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT 'Table aether_active_upgrades créée' AS status;
