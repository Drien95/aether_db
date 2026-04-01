-- [[ AETHER MAILING - Cooldown d'envoi partagé entre serveurs ]]
-- Ajoute last_mail_sent_at sur aether_players (par UUID de personnage)
-- pour que le rate-limit SEND_COOLDOWN soit persistant et cross-serveur.

ALTER TABLE aether_players
    ADD COLUMN last_mail_sent_at INT NOT NULL DEFAULT 0;
