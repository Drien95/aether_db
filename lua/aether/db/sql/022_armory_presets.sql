-- ============================================================================
-- AETHER ARMORY - MIGRATION 022 : Presets d'attachements
-- ============================================================================
-- Chaque preset = un loadout nommé par arme + personnage.
-- Un joueur peut avoir plusieurs presets pour la même arme (différentes configs).
-- La clé unique (char_uuid, weapon_class, preset_name) garantit l'unicité du nom.
-- ============================================================================

CREATE TABLE IF NOT EXISTS aether_armory_presets (
    id           INT UNSIGNED    AUTO_INCREMENT PRIMARY KEY,
    char_uuid    VARCHAR(64)     NOT NULL,
    weapon_class VARCHAR(128)    NOT NULL,
    preset_name  VARCHAR(64)     NOT NULL,
    loadout_json TEXT            NOT NULL,
    created_at   INT UNSIGNED    NOT NULL DEFAULT 0,
    updated_at   INT UNSIGNED    NOT NULL DEFAULT 0,
    UNIQUE KEY uk_preset  (char_uuid, weapon_class, preset_name),
    INDEX  idx_preset_wep (char_uuid, weapon_class)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
