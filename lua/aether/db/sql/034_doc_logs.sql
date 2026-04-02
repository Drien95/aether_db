-- [[ AETHER DOCUMENTATION - Table des logs d'audit ]]
-- Migration 034
-- Trace toutes les opérations CRUD sur les documents (add, edit, delete, restore,
-- changement clearance, gestion grants cross-org, mise à jour statut sécurité).
-- Rétention : 180 jours (purge quotidienne via timer serveur).

CREATE TABLE IF NOT EXISTS aether_doc_logs (
    id          INT          NOT NULL AUTO_INCREMENT,
    doc_id      VARCHAR(64)  NOT NULL,
    scope       VARCHAR(8)   NOT NULL,                   -- 'server' | 'org'
    org_id      VARCHAR(64)  NULL,                       -- NULL si scope='server'
    action      VARCHAR(20)  NOT NULL,                   -- add|edit|delete|restore|sec_update|clearance_change|grant_add|grant_remove
    actor_uuid  VARCHAR(64)  NOT NULL,
    details     TEXT         NULL,                       -- JSON diff avant/après pour edit/clearance_change
    created_at  INT          NOT NULL,
    PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
