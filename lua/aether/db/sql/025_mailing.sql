-- [[ AETHER MAILING - Table des messages inter-personnages ]]
-- Migration 025

CREATE TABLE IF NOT EXISTS aether_mails (
    id               VARCHAR(64)  PRIMARY KEY,
    sender_uuid      VARCHAR(64)  NOT NULL,
    sender_name      VARCHAR(128) NOT NULL DEFAULT '',
    sender_badge     VARCHAR(64)  NOT NULL DEFAULT '',
    receiver_uuid    VARCHAR(64)  NOT NULL,
    receiver_name    VARCHAR(128) NOT NULL DEFAULT '',
    subject          VARCHAR(128) NOT NULL DEFAULT '',
    body             TEXT         NOT NULL,
    sent_at          BIGINT       NOT NULL,
    read_at          BIGINT       DEFAULT NULL,         -- NULL = non lu
    deleted_by_sender    TINYINT  DEFAULT 0,
    deleted_by_receiver  TINYINT  DEFAULT 0,

    INDEX idx_mail_receiver (receiver_uuid),
    INDEX idx_mail_sender   (sender_uuid),
    INDEX idx_mail_sent     (sent_at)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
