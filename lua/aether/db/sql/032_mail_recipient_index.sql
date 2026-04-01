-- [[ AETHER MAILING - Index composite pour CountUnread (poll timer) ]]
-- Couvre la requête : WHERE recipient_uuid IN (...) AND read_at IS NULL AND deleted = 0
CREATE INDEX IF NOT EXISTS idx_mr_unread ON aether_mail_recipients (recipient_uuid, deleted, read_at);
