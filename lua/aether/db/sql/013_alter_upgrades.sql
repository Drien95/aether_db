-- ============================================================================
-- Migration 009: Ajouter la colonne data à aether_upgrades
-- ============================================================================
-- Cette colonne permet de stocker des metadonnees JSON extensibles
-- pour les upgrades (applies_to, tier, category, weapon_keys, etc.)
-- ============================================================================

ALTER TABLE aether_upgrades
    ADD COLUMN data TEXT AFTER icon;