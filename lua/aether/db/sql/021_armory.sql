-- ============================================================================
-- AETHER ARMORY - MIGRATION 021
-- ============================================================================
-- Table des unlocks d'armes par personnage (char_uuid = UUID Aether du perso)
-- Chaque joueur doit payer 1000 dataris pour débloquer une arme de recherche.
-- ============================================================================

CREATE TABLE IF NOT EXISTS aether_armory_unlocks (
    char_uuid    VARCHAR(64)  NOT NULL,
    weapon_class VARCHAR(64)  NOT NULL,
    unlocked_at  BIGINT       NOT NULL DEFAULT 0,
    PRIMARY KEY (char_uuid, weapon_class),
    INDEX idx_armory_uuid (char_uuid)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
