-- Migration 017: Add shared wallet system
-- Creates aether_wallets table for per-SteamID balance shared across characters.
-- Balance is independent of any character; one entry per SteamID.

CREATE TABLE IF NOT EXISTS aether_wallets (
    steam_id   VARCHAR(255)  NOT NULL PRIMARY KEY,
    balance    DECIMAL(15,2) NOT NULL DEFAULT 100.00,
    updated_at BIGINT        NOT NULL DEFAULT 0
);

CREATE INDEX idx_wallet_updated ON aether_wallets(updated_at);
