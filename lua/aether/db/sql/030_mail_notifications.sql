-- [[ AETHER MAILING - Table de notifications inter-serveurs ]]
-- Permet la livraison cross-server des nouveaux mails (Option C).
-- Chaque serveur poll cette table toutes les ~12s pour ses joueurs connectés,
-- marque delivered=1 après envoi du push, et purge les entrées livrées > 24h.

CREATE TABLE IF NOT EXISTS aether_mail_notifications (
    id             INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    recipient_uuid VARCHAR(36)  NOT NULL,
    mail_id        VARCHAR(64)  NOT NULL,
    delivered      TINYINT(1)   NOT NULL DEFAULT 0,
    created_at     INT          NOT NULL
);

-- Lookup : toutes les notifs non livrées pour un ensemble d'UUIDs connectés
CREATE INDEX idx_mn_lookup ON aether_mail_notifications (recipient_uuid, delivered);

-- Purge périodique des entrées livrées
CREATE INDEX idx_mn_purge  ON aether_mail_notifications (created_at);
