-- [[ AETHER DOCUMENTATION - Tables principales ]]
-- Migration 033
-- aether_docs         : documents (URLs externes) par scope serveur ou orga
-- aether_doc_clearance_grants : accès cross-org par niveau d'habilitation RP

CREATE TABLE IF NOT EXISTS aether_docs (
    id              VARCHAR(64)  NOT NULL,
    scope           VARCHAR(8)   NOT NULL DEFAULT 'org',     -- 'server' | 'org'
    org_id          VARCHAR(64)  NULL,                       -- NULL si scope='server'
    category        VARCHAR(64)  NULL,                       -- catégorie RP optionnelle
    title           VARCHAR(128) NOT NULL,
    url             TEXT         NOT NULL,                   -- max 2048, validé applicativement
    description     VARCHAR(500) NULL,
    display_order   INT          NOT NULL DEFAULT 0,

    -- Habilitation RP : priority du rôle requise pour accéder au doc
    -- 0 = tout membre avec doc_view, 10 = membre, 50 = officier, 100 = owner
    clearance_level INT          NOT NULL DEFAULT 0,

    -- Statut pipeline sécurité (GSB + VT)
    sec_status      VARCHAR(12)  NOT NULL DEFAULT 'pending', -- pending|safe|flagged|skipped|error
    sec_score       VARCHAR(32)  NULL,                       -- ex : "VT:2/72" ou "GSB:MALWARE"
    sec_checked_at  INT          NULL,
    sec_source      VARCHAR(12)  NULL,                       -- 'gsb' | 'vt' | 'whitelist'

    -- Traçabilité
    added_by        VARCHAR(64)  NOT NULL,
    added_at        INT          NOT NULL,
    updated_by      VARCHAR(64)  NULL,
    updated_at      INT          NULL,

    -- Soft delete
    deleted         TINYINT(1)   NOT NULL DEFAULT 0,
    deleted_by      VARCHAR(64)  NULL,
    deleted_at      INT          NULL,

    PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Accès cross-org : accorde à une orga tierce l'accès aux docs d'une autre orga
-- Ex : l'Amirauté (grantee) peut voir les docs niveau 50 du 21st Corps (source)
-- à condition que le membre ait priority >= min_priority dans son orga (grantee)
CREATE TABLE IF NOT EXISTS aether_doc_clearance_grants (
    id              INT          NOT NULL AUTO_INCREMENT,
    source_org_id   VARCHAR(64)  NOT NULL,  -- orga propriétaire des docs
    grantee_org_id  VARCHAR(64)  NOT NULL,  -- orga bénéficiaire de l'accès
    min_priority    INT          NOT NULL DEFAULT 0, -- priority min dans l'orga grantee
    clearance_level INT          NOT NULL DEFAULT 0, -- niveau de clearance accordé
    granted_by      VARCHAR(64)  NOT NULL,
    granted_at      INT          NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_grant (source_org_id, grantee_org_id, clearance_level)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
