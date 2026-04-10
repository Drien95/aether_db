-- =============================================================================
-- Migration 037 — aether_sabaac
-- Tables nécessaires au fonctionnement du jeu de Sabacc.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Tables de jeu — sabacc pot persistant entre les sessions
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aether_sabaac_tables (
    id          VARCHAR(64)     NOT NULL,
    sabacc_pot  DOUBLE          NOT NULL DEFAULT 0,
    created_at  BIGINT          NOT NULL DEFAULT 0,
    updated_at  BIGINT          NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

-- -----------------------------------------------------------------------------
-- Historique des parties terminées
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aether_sabaac_sessions (
    id           VARCHAR(64)    NOT NULL,
    table_id     VARCHAR(64)    NOT NULL DEFAULT '',
    started_at   BIGINT         NOT NULL DEFAULT 0,
    ended_at     BIGINT         NOT NULL DEFAULT 0,
    winner_id    VARCHAR(64)    DEFAULT NULL,
    hand_pot     DOUBLE         NOT NULL DEFAULT 0,
    sabacc_pot   DOUBLE         NOT NULL DEFAULT 0,
    player_count INT            NOT NULL DEFAULT 0,
    result_type  VARCHAR(32)    NOT NULL DEFAULT 'standard',
    PRIMARY KEY (id),
    INDEX idx_sabaac_sess_table  (table_id),
    INDEX idx_sabaac_sess_winner (winner_id),
    INDEX idx_sabaac_sess_time   (ended_at)
);

-- -----------------------------------------------------------------------------
-- Statistiques cumulées par joueur
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aether_sabaac_players (
    steam_id      VARCHAR(64)   NOT NULL,
    games_played  INT           NOT NULL DEFAULT 0,
    games_won     INT           NOT NULL DEFAULT 0,
    pure_sabaccs  INT           NOT NULL DEFAULT 0,
    idiot_arrays  INT           NOT NULL DEFAULT 0,
    bomb_outs     INT           NOT NULL DEFAULT 0,
    credits_won   DOUBLE        NOT NULL DEFAULT 0,
    credits_lost  DOUBLE        NOT NULL DEFAULT 0,
    last_played   BIGINT        NOT NULL DEFAULT 0,
    PRIMARY KEY (steam_id)
);

-- -----------------------------------------------------------------------------
-- Logs spécifiques aether_sabaac
-- Niveau : INFO | WARN | ERROR
-- Rotation automatique : entrées > DBLogRotationDays jours purgées par sv_log
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS aether_sabaac_logs (
    id        VARCHAR(64)    NOT NULL,
    timestamp BIGINT         NOT NULL DEFAULT 0,
    level     VARCHAR(8)     NOT NULL DEFAULT 'INFO',
    code      INT            DEFAULT NULL,
    table_id  VARCHAR(64)    DEFAULT NULL,
    actor_id  VARCHAR(64)    DEFAULT NULL,
    message   TEXT           NOT NULL,
    PRIMARY KEY (id),
    INDEX idx_sabaac_log_level    (level),
    INDEX idx_sabaac_log_table    (table_id),
    INDEX idx_sabaac_log_time     (timestamp),
    INDEX idx_sabaac_log_actor    (actor_id)
);
