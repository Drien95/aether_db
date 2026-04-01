# Changelog — 2026-03-31
Addons: `aether_db`

---

## Migrations mail

### `030_mail_notifications.sql`

Nouvelle table `aether_mail_notifications` pour les notifications cross-serveurs :

| Colonne | Type | Description |
|---------|------|-------------|
| `id` | INT AUTO_INCREMENT PK | |
| `recipient_uuid` | VARCHAR | UUID du destinataire |
| `mail_id` | VARCHAR | ID du mail concerné |
| `delivered` | TINYINT(1) | 0 = en attente, 1 = livré |
| `created_at` | INT | Timestamp de création |

Index :
- `idx_mn_lookup (recipient_uuid, delivered)` — requête poll timer
- `idx_mn_purge (created_at)` — purge quotidienne

### `031_mail_cooldown.sql`

```sql
ALTER TABLE aether_players ADD COLUMN last_mail_sent_at INT NOT NULL DEFAULT 0;
```

Stocke le timestamp du dernier envoi mail par personnage — utilisé pour le rate limiting cross-serveurs (partagé entre instances).

### `032_mail_recipient_index.sql`

```sql
CREATE INDEX IF NOT EXISTS idx_mr_unread
ON aether_mail_recipients (recipient_uuid, deleted, read_at);
```

Index composite couvrant la requête CountUnread du poll timer :
`WHERE recipient_uuid IN (...) AND read_at IS NULL AND deleted = 0 GROUP BY recipient_uuid`
