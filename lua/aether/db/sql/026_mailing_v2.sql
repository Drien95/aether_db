-- [[ AETHER MAILING V2 - Multi-recipient (TO / CC / BCC) ]]
-- Ajoute la table de destinataires multi ; migre les données existantes.
-- Les colonnes receiver_uuid/read_at/deleted_by_receiver de aether_mails
-- ne sont plus utilisées par le nouveau code mais restent pour compatibilité.

CREATE TABLE IF NOT EXISTS aether_mail_recipients (
    id              VARCHAR(64)  NOT NULL,
    mail_id         VARCHAR(64)  NOT NULL,
    recipient_uuid  VARCHAR(64)  NOT NULL,
    recipient_name  VARCHAR(128) NOT NULL DEFAULT '',
    type            VARCHAR(3)   NOT NULL DEFAULT 'TO',   -- TO | CC | BCC
    read_at         BIGINT       DEFAULT NULL,
    deleted         TINYINT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    INDEX idx_mr_mail_id          (mail_id),
    INDEX idx_mr_recipient        (recipient_uuid),
    INDEX idx_mr_recipient_del    (recipient_uuid, deleted)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Migration des mails envoyés avec l'ancien système mono-destinataire
INSERT IGNORE INTO aether_mail_recipients
    (id, mail_id, recipient_uuid, recipient_name, type, read_at, deleted)
SELECT
    CONCAT(id, '_migr'),
    id,
    receiver_uuid,
    COALESCE(receiver_name, ''),
    'TO',
    read_at,
    COALESCE(deleted_by_receiver, 0)
FROM aether_mails
WHERE receiver_uuid IS NOT NULL AND receiver_uuid != '';
