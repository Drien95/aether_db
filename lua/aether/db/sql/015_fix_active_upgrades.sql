-- ============================================================================
-- Fix aether_active_upgrades structure
-- ============================================================================
-- Correction de la PRIMARY KEY pour inclure vehicle_class
-- et suppression de la FOREIGN KEY vers aether_upgrades (table supprimée)
-- ============================================================================

-- 1. Supprimer la FOREIGN KEY si elle existe
ALTER TABLE aether_active_upgrades DROP FOREIGN KEY IF EXISTS aether_active_upgrades_ibfk_1;

-- 2. Supprimer l'ancienne PRIMARY KEY
ALTER TABLE aether_active_upgrades DROP PRIMARY KEY;

-- 3. Créer la nouvelle PRIMARY KEY avec vehicle_class
ALTER TABLE aether_active_upgrades ADD PRIMARY KEY (account_id, upgrade_id, vehicle_class);

SELECT 'aether_active_upgrades corrigée' AS status;
