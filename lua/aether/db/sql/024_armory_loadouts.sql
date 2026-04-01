-- ============================================================================
-- AETHER ARMORY - MIGRATION 023 : Loadouts d'attachements équipés
-- ============================================================================
-- Stocke le dernier loadout équipé par personnage + arme.
-- Partagé entre serveurs (même DB MySQL) → les attachements survivent aux
-- déconnexions et changements de serveur.
-- Clé unique : (char_uuid, weapon_class) — un seul loadout actif par arme.
-- ============================================================================

CREATE TABLE IF NOT EXISTS aether_armory_loadouts (
    id           INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
    char_uuid    VARCHAR(64)     NOT NULL,
    weapon_class VARCHAR(128)    NOT NULL,
    loadout_json TEXT            NOT NULL,
    updated_at   INT UNSIGNED    NOT NULL DEFAULT 0,
    UNIQUE KEY uk_loadout     (char_uuid, weapon_class),
    INDEX  idx_loadout_char   (char_uuid)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
