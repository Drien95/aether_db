-- [[ MIGRATION V7 ]]
-- Optimization: Add Indexes for frequent lookups

Aether.Migration = Aether.Migration or {}

Aether.Migration.V7 = function()
    print("[AETHER] Running Migration V7 (Indexes)...")

    local queries = {
        -- Inventory Lookups (owner_id)
        "CREATE INDEX IF NOT EXISTS idx_items_owner ON aether_items(owner_id);",

        -- Account Type Lookups (e.g. FetchAll Orgs)
        "CREATE INDEX IF NOT EXISTS idx_accounts_type ON aether_accounts(type);",

        -- Transaction History Lookups
        "CREATE INDEX IF NOT EXISTS idx_trans_sender ON aether_transactions(sender_id);",
        "CREATE INDEX IF NOT EXISTS idx_trans_receiver ON aether_transactions(receiver_id);",

        -- Logs Lookups
        "CREATE INDEX IF NOT EXISTS idx_logs_actor ON aether_logs(actor_id);",
        "CREATE INDEX IF NOT EXISTS idx_logs_inv_actor ON aether_logs_inventory(actor_id);",
        "CREATE INDEX IF NOT EXISTS idx_logs_admin_actor ON aether_logs_admin(actor_id);"
    }

    for _, q in ipairs(queries) do
        Aether.Database.Query(q, function() end, function(err)
            -- Ignore "Duplicate key name" if running on MySQL (IF NOT EXISTS handles SQLite/MySQL 8, but older keys might error)
            -- Just print low prio
            -- print("[AETHER] Index creation note: " .. err)
        end)
    end
end
