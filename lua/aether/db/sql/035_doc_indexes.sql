-- [[ AETHER DOCUMENTATION - Index de performance ]]
-- Migration 035
-- Tous les index sont créés séparément pour compatibilité SQLite (le transpileur
-- aether_db extrait les INDEX inline des CREATE TABLE et les crée individuellement).

-- aether_docs : liste par scope+orga (query principale de FindByOrg / FindServer)
CREATE INDEX IF NOT EXISTS idx_docs_scope_org    ON aether_docs (scope, org_id, deleted);

-- aether_docs : filtrage par niveau d'habilitation (query CanViewDoc)
CREATE INDEX IF NOT EXISTS idx_docs_clearance    ON aether_docs (org_id, clearance_level, deleted);

-- aether_docs : lookup rapide des docs en attente de vérification sécurité
CREATE INDEX IF NOT EXISTS idx_docs_sec_status   ON aether_docs (sec_status);

-- aether_doc_logs : logs d'un document spécifique
CREATE INDEX IF NOT EXISTS idx_doclogs_doc       ON aether_doc_logs (doc_id);

-- aether_doc_logs : historique d'une orga trié par date (pagination)
CREATE INDEX IF NOT EXISTS idx_doclogs_org       ON aether_doc_logs (org_id, created_at);

-- aether_doc_logs : actions d'un acteur spécifique
CREATE INDEX IF NOT EXISTS idx_doclogs_actor     ON aether_doc_logs (actor_uuid);

-- aether_doc_logs : purge quotidienne des logs anciens
CREATE INDEX IF NOT EXISTS idx_doclogs_purge     ON aether_doc_logs (created_at);

-- aether_doc_clearance_grants : grants dont une orga est propriétaire
CREATE INDEX IF NOT EXISTS idx_grants_source     ON aether_doc_clearance_grants (source_org_id);

-- aether_doc_clearance_grants : grants dont une orga est bénéficiaire
CREATE INDEX IF NOT EXISTS idx_grants_grantee    ON aether_doc_clearance_grants (grantee_org_id);
