-- [[ AETHER MAILING V2 - Fix receiver_uuid nullable ]]
-- La migration 026 a créé aether_mail_recipients mais receiver_uuid
-- dans aether_mails est resté NOT NULL, bloquant les nouveaux envois.
-- On la rend nullable puisqu'elle n'est plus utilisée par le nouveau code.

ALTER TABLE aether_mails
    MODIFY receiver_uuid VARCHAR(64) NULL DEFAULT NULL,
    MODIFY receiver_name VARCHAR(128) NULL DEFAULT NULL;
