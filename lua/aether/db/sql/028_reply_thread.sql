-- [[ AETHER MAILING V2 - Support réponses et fils de conversation ]]
-- reply_to_id : ID du mail auquel on répond (NULL si nouveau mail)
-- thread_id   : ID du premier mail du fil (thread_id = id pour les mails racines)

ALTER TABLE aether_mails
    ADD COLUMN reply_to_id VARCHAR(64) NULL DEFAULT NULL,
    ADD COLUMN thread_id   VARCHAR(64) NULL DEFAULT NULL,
    ADD INDEX idx_mail_thread (thread_id);

-- Les mails existants sont leur propre racine de thread
UPDATE aether_mails SET thread_id = id WHERE thread_id IS NULL;
