-- [[ AETHER CORE - SQL SCHEMA FINAL ]]
-- Engine: InnoDB
-- Charset: utf8mb4 (Support Emojis/Special Chars)

-- 1. ACCOUNTS (Table Mère)
-- MULTI-ACCOUNT SYSTEM: Player accounts use UUID (not SteamID)
-- A player (SteamID) can have multiple character accounts (UUIDs)
CREATE TABLE IF NOT EXISTS aether_accounts (
    id VARCHAR(64) PRIMARY KEY,        -- UUID for player accounts, "org_..." for orgs
    type VARCHAR(20) DEFAULT 'player', -- 'player', 'org'
    owner_id VARCHAR(64),              -- For orgs: owner SteamID; For players: see aether_players mapping
    balance DOUBLE DEFAULT 0,          -- Argent
    materials TEXT,                    -- JSON
    
    -- Méta Inventaire
    inv_width INT DEFAULT 6,
    inv_height INT DEFAULT 4,
    
    last_updated BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_acc_owner (owner_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. ORGANIZATIONS (Extension Méta)
CREATE TABLE IF NOT EXISTS aether_orgs (
    id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    owner_id VARCHAR(64) NOT NULL,
    
    -- Données lourdes
    roles_data MEDIUMTEXT,   -- JSON
    members_data MEDIUMTEXT, -- JSON
    params TEXT,             -- JSON
    
    created_at BIGINT,
    FOREIGN KEY (id) REFERENCES aether_accounts(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 3. ITEMS (Contenu Inventaire)
CREATE TABLE IF NOT EXISTS aether_items (
    uuid VARCHAR(64) PRIMARY KEY,
    definition_id VARCHAR(64) NOT NULL,
    owner_id VARCHAR(64) NOT NULL,
    
    amount INT DEFAULT 1,
    grid_x INT DEFAULT -1,
    grid_y INT DEFAULT -1,
    is_rotated TINYINT DEFAULT 0,
    
    data TEXT,
    is_dirty TINYINT DEFAULT 0,
    
    INDEX idx_item_owner (owner_id),
    FOREIGN KEY (owner_id) REFERENCES aether_accounts(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 4. DEFINITIONS
CREATE TABLE IF NOT EXISTS aether_definitions (
    class_id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(128),
    category_id VARCHAR(64),
    type VARCHAR(32),
    
    model VARCHAR(255),
    icon VARCHAR(255),
    description TEXT,
    
    weight DOUBLE DEFAULT 0,
    width INT DEFAULT 1,
    height INT DEFAULT 1,
    
    is_buyable TINYINT DEFAULT 0,
    price DOUBLE DEFAULT 0,
    
    materials TEXT,
    data TEXT,
    
    INDEX idx_def_cat (category_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 5. ROLE TEMPLATES
CREATE TABLE IF NOT EXISTS aether_role_templates (
    id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(128),
    roles_data TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 6. TRANSACTIONS
CREATE TABLE IF NOT EXISTS aether_transactions (
    id VARCHAR(64) PRIMARY KEY,
    timestamp BIGINT,
    sender_id VARCHAR(64),
    receiver_id VARCHAR(64),
    amount DOUBLE,
    reason VARCHAR(255),
    
    INDEX idx_trans_time (timestamp),
    INDEX idx_trans_sender (sender_id),
    INDEX idx_trans_receiver (receiver_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 7. INVENTORY LOGS
CREATE TABLE IF NOT EXISTS aether_logs_inventory (
    id VARCHAR(64) PRIMARY KEY,
    timestamp BIGINT,
    actor_id VARCHAR(64),
    action VARCHAR(32),
    class_id VARCHAR(64),
    quantity INT,
    source VARCHAR(64),
    
    INDEX idx_invlog_actor (actor_id),
    INDEX idx_invlog_time (timestamp)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 8. ADMIN LOGS
CREATE TABLE IF NOT EXISTS aether_logs_admin (
    id VARCHAR(64) PRIMARY KEY,
    timestamp BIGINT,
    actor_id VARCHAR(64),
    target_id VARCHAR(64),
    command VARCHAR(64),
    args TEXT,
    
    INDEX idx_admin_actor (actor_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 9. GENERIC LOGS
CREATE TABLE IF NOT EXISTS aether_logs (
    id VARCHAR(64) PRIMARY KEY,
    timestamp BIGINT,
    actor_id VARCHAR(64),
    type VARCHAR(32),
    message TEXT,
    
    INDEX idx_log_type (type)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
