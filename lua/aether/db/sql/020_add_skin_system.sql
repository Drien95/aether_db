-- Migration 018: Skin system
-- aether_skin_catalog  : catalogue admin des skins personnalisés (par faction/corps)
-- aether_character_skins : collection de skins débloqués par personnage (UUID)

CREATE TABLE IF NOT EXISTS aether_skin_catalog (
    id          INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)  NOT NULL,
    model_path  VARCHAR(255)  NOT NULL,
    skin_num    INT           NOT NULL DEFAULT 0,
    bodygroups  TEXT          NULL,
    faction     VARCHAR(32)   NOT NULL,
    corps_id    VARCHAR(64)   NULL,
    added_by    VARCHAR(32)   NOT NULL DEFAULT '',
    created_at  BIGINT        NOT NULL DEFAULT 0,
    INDEX idx_skin_faction (faction),
    INDEX idx_skin_corps   (corps_id)
);

CREATE TABLE IF NOT EXISTS aether_character_skins (
    id              INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    character_uuid  VARCHAR(64) NOT NULL,
    catalog_id      INT         NOT NULL,
    is_equipped     TINYINT(1)  NOT NULL DEFAULT 0,
    assigned_by     VARCHAR(32) NOT NULL DEFAULT '',
    assigned_at     BIGINT      NOT NULL DEFAULT 0,
    INDEX idx_char_uuid (character_uuid),
    INDEX idx_equipped  (character_uuid, is_equipped)
);
