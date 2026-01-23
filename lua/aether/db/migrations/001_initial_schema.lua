-- [[ INITIAL SCHEMA MIGRATION V1 ]]
return [[
    -- 1. ACCOUNTS (Mother Table)
    CREATE TABLE IF NOT EXISTS aether_accounts (
        id VARCHAR(64) PRIMARY KEY,
        type VARCHAR(20) DEFAULT 'player',
        owner_id VARCHAR(64),
        balance DOUBLE DEFAULT 0,
        materials TEXT,
        inv_width INT DEFAULT 6,
        inv_height INT DEFAULT 4,
        last_updated BIGINT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    CREATE INDEX idx_acc_owner ON aether_accounts(owner_id);

    -- 2. ORGANIZATIONS (Meta Extension)
    CREATE TABLE IF NOT EXISTS aether_orgs (
        id VARCHAR(64) PRIMARY KEY,
        name VARCHAR(128) NOT NULL,
        owner_id VARCHAR(64) NOT NULL,
        roles_data MEDIUMTEXT,
        members_data MEDIUMTEXT,
        params TEXT,
        created_at BIGINT,
        FOREIGN KEY (id) REFERENCES aether_accounts(id) ON DELETE CASCADE
    );

    -- 3. ITEMS (Inventory Content)
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
        FOREIGN KEY (owner_id) REFERENCES aether_accounts(id) ON DELETE CASCADE
    );
    CREATE INDEX idx_item_owner ON aether_items(owner_id);

    -- 4. DEFINITIONS (Static Data / Catalogue)
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
        data TEXT
    );
    CREATE INDEX idx_def_cat ON aether_definitions(category_id);

    -- 5. ROLE TEMPLATES
    CREATE TABLE IF NOT EXISTS aether_role_templates (
        id VARCHAR(64) PRIMARY KEY,
        name VARCHAR(128),
        roles_data TEXT
    );

    -- 6. TRANSACTIONS
    CREATE TABLE IF NOT EXISTS aether_transactions (
        id VARCHAR(64) PRIMARY KEY,
        timestamp BIGINT,
        sender_id VARCHAR(64),
        receiver_id VARCHAR(64),
        amount DOUBLE,
        reason VARCHAR(255)
    );
    CREATE INDEX idx_trans_time ON aether_transactions(timestamp);
    CREATE INDEX idx_trans_sender ON aether_transactions(sender_id);
    CREATE INDEX idx_trans_receiver ON aether_transactions(receiver_id);

    -- 7. INVENTORY LOGS
    CREATE TABLE IF NOT EXISTS aether_logs_inventory (
        id VARCHAR(64) PRIMARY KEY,
        timestamp BIGINT,
        actor_id VARCHAR(64),
        action VARCHAR(32),
        class_id VARCHAR(64),
        quantity INT,
        source VARCHAR(64)
    );
    CREATE INDEX idx_invlog_actor ON aether_logs_inventory(actor_id);
    CREATE INDEX idx_invlog_time ON aether_logs_inventory(timestamp);

    -- 8. ADMIN LOGS
    CREATE TABLE IF NOT EXISTS aether_logs_admin (
        id VARCHAR(64) PRIMARY KEY,
        timestamp BIGINT,
        actor_id VARCHAR(64),
        target_id VARCHAR(64),
        command VARCHAR(64),
        args TEXT
    );
    CREATE INDEX idx_admin_actor ON aether_logs_admin(actor_id);

    -- 9. GENERIC LOGS
    CREATE TABLE IF NOT EXISTS aether_logs (
        id VARCHAR(64) PRIMARY KEY,
        timestamp BIGINT,
        actor_id VARCHAR(64),
        type VARCHAR(32),
        message TEXT
    );
    CREATE INDEX idx_log_type ON aether_logs(type);
]]
