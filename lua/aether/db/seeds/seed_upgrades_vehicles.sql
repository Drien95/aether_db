-- ============================================================================
-- AETHER RESEARCH - SEED UPGRADES VEHICULES
-- ============================================================================
-- Fichier: sql/seed_upgrades_vehicles.sql
-- Cree les tech nodes et edges pour les upgrades de vehicules
-- Date: 12/02/2026
--
-- STRUCTURE:
--   - Les upgrades sont definis en LUA (sh_upgrades.lua)
--   - Ce fichier cree seulement les TECH NODES qui pointent vers ces upgrades
--   - Les edges creent l'arbre de dependances
--
-- ORGANISATION:
--   - Par vehicule
--   - Par categorie d'upgrade (hp, speed, cannons, etc.)
--   - Par tier (T1 → T2 → T3 → T4...)
--   - Combos speciaux (necessite plusieurs T2 pour debloquer un T3, etc.)
-- ============================================================================

-- ============================================================================
-- V-19 TORRENT - UPGRADES
-- ============================================================================

-- HP (Blindage) T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_hp_t1', 'V-19: Blindage Renforce T1',
     'Ajoute 200 points de vie au V-19.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'v19_hp_t1',
     '{"fer":20,"durasteel":10}', 'materials/icons/upgrades/hp.png', '{}'),

    ('tech_v19_hp_t2', 'V-19: Blindage Renforce T2',
     'Ajoute 400 points de vie au V-19.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'v19_hp_t2',
     '{"fer":40,"durasteel":20}', 'materials/icons/upgrades/hp.png', '{}'),

    ('tech_v19_hp_t3', 'V-19: Blindage Renforce T3',
     'Ajoute 600 points de vie au V-19.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'v19_hp_t3',
     '{"fer":60,"durasteel":30}', 'materials/icons/upgrades/hp.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- Armor (Reduction degats) T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_armor_t1', 'V-19: Plaques Composites T1',
     'Reduit les degats recus de 10%.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'v19_armor_t1',
     '{"fer":20,"durasteel":10}', 'materials/icons/upgrades/armor.png', '{}'),

    ('tech_v19_armor_t2', 'V-19: Plaques Composites T2',
     'Reduit les degats recus de 20%.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'v19_armor_t2',
     '{"fer":40,"durasteel":20}', 'materials/icons/upgrades/armor.png', '{}'),

    ('tech_v19_armor_t3', 'V-19: Plaques Composites T3',
     'Reduit les degats recus de 30%.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'v19_armor_t3',
     '{"fer":60,"durasteel":30}', 'materials/icons/upgrades/armor.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- Speed (Reacteurs) T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_speed_t1', 'V-19: Reacteurs Optimises T1',
     'Augmente la vitesse de 15%.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'v19_speed_t1',
     '{"fer":20,"circuits":10}', 'materials/icons/upgrades/engine.png', '{}'),

    ('tech_v19_speed_t2', 'V-19: Reacteurs Optimises T2',
     'Augmente la vitesse de 30%.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'v19_speed_t2',
     '{"fer":40,"circuits":20}', 'materials/icons/upgrades/engine.png', '{}'),

    ('tech_v19_speed_t3', 'V-19: Reacteurs Optimises T3',
     'Augmente la vitesse de 50%.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'v19_speed_t3',
     '{"fer":60,"circuits":30}', 'materials/icons/upgrades/engine.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- Cannons T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_cannons_t1', 'V-19: Canons Ameliores T1',
     'Augmente les degats des canons de 20%.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'v19_cannons_t1',
     '{"circuits":15,"cristaux":5}', 'materials/icons/upgrades/weapon.png', '{}'),

    ('tech_v19_cannons_t2', 'V-19: Canons Ameliores T2',
     'Augmente les degats des canons de 40%.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'v19_cannons_t2',
     '{"circuits":30,"cristaux":10}', 'materials/icons/upgrades/weapon.png', '{}'),

    ('tech_v19_cannons_t3', 'V-19: Canons Ameliores T3',
     'Augmente les degats des canons de 60%.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'v19_cannons_t3',
     '{"circuits":45,"cristaux":15}', 'materials/icons/upgrades/weapon.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- Missiles T1-T2
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_missiles_t1', 'V-19: Missiles Ameliores T1',
     'Augmente capacite et degats des missiles.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'v19_missiles_t1',
     '{"explosifs":15,"circuits":10}', 'materials/icons/upgrades/missile.png', '{}'),

    ('tech_v19_missiles_t2', 'V-19: Missiles Ameliores T2',
     'Amelioration avancee des missiles.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'v19_missiles_t2',
     '{"explosifs":30,"circuits":20}', 'materials/icons/upgrades/missile.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- ============================================================================
-- Z-95 HEADHUNTER - UPGRADES
-- ============================================================================

-- HP T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_z95_hp_t1', 'Z-95: Blindage Renforce T1',
     'Ajoute 150 points de vie au Z-95.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'z95_hp_t1',
     '{"fer":20,"durasteel":10}', 'materials/icons/upgrades/hp.png', '{}'),

    ('tech_z95_hp_t2', 'Z-95: Blindage Renforce T2',
     'Ajoute 300 points de vie au Z-95.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'z95_hp_t2',
     '{"fer":40,"durasteel":20}', 'materials/icons/upgrades/hp.png', '{}'),

    ('tech_z95_hp_t3', 'Z-95: Blindage Renforce T3',
     'Ajoute 500 points de vie au Z-95.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'z95_hp_t3',
     '{"fer":60,"durasteel":30}', 'materials/icons/upgrades/hp.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- Shield T1-T3
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_z95_shield_t1', 'Z-95: Generateur de Bouclier T1',
     'Augmente le bouclier de 100 points.',
     1, 100, 5000, 'chasseurs', 'upgrade', 'z95_shield_t1',
     '{"circuits":20,"energie":10}', 'materials/icons/upgrades/shield.png', '{}'),

    ('tech_z95_shield_t2', 'Z-95: Generateur de Bouclier T2',
     'Augmente le bouclier de 250 points.',
     2, 200, 10000, 'chasseurs', 'upgrade', 'z95_shield_t2',
     '{"circuits":40,"energie":20}', 'materials/icons/upgrades/shield.png', '{}'),

    ('tech_z95_shield_t3', 'Z-95: Generateur de Bouclier T3',
     'Augmente le bouclier de 500 points.',
     3, 400, 20000, 'chasseurs', 'upgrade', 'z95_shield_t3',
     '{"circuits":60,"energie":30}', 'materials/icons/upgrades/shield.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- Speed, Cannons, Torpedoes (similaire à V-19)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_z95_speed_t1', 'Z-95: Reacteurs Optimises T1', 'Augmente la vitesse de 15%.', 1, 100, 5000, 'chasseurs', 'upgrade', 'z95_speed_t1', '{"fer":20,"circuits":10}', 'materials/icons/upgrades/engine.png', '{}'),
    ('tech_z95_speed_t2', 'Z-95: Reacteurs Optimises T2', 'Augmente la vitesse de 30%.', 2, 200, 10000, 'chasseurs', 'upgrade', 'z95_speed_t2', '{"fer":40,"circuits":20}', 'materials/icons/upgrades/engine.png', '{}'),
    ('tech_z95_speed_t3', 'Z-95: Reacteurs Optimises T3', 'Augmente la vitesse de 50%.', 3, 400, 20000, 'chasseurs', 'upgrade', 'z95_speed_t3', '{"fer":60,"circuits":30}', 'materials/icons/upgrades/engine.png', '{}'),

    ('tech_z95_cannons_t1', 'Z-95: Lasers Ameliores T1', 'Augmente les degats de 20%.', 1, 100, 5000, 'chasseurs', 'upgrade', 'z95_cannons_t1', '{"circuits":15,"cristaux":5}', 'materials/icons/upgrades/weapon.png', '{}'),
    ('tech_z95_cannons_t2', 'Z-95: Lasers Ameliores T2', 'Augmente les degats de 40%.', 2, 200, 10000, 'chasseurs', 'upgrade', 'z95_cannons_t2', '{"circuits":30,"cristaux":10}', 'materials/icons/upgrades/weapon.png', '{}'),
    ('tech_z95_cannons_t3', 'Z-95: Lasers Ameliores T3', 'Augmente les degats de 60%.', 3, 400, 20000, 'chasseurs', 'upgrade', 'z95_cannons_t3', '{"circuits":45,"cristaux":15}', 'materials/icons/upgrades/weapon.png', '{}'),

    ('tech_z95_torpedoes_t1', 'Z-95: Torpilles Proton T1', 'Ameliore les torpilles proton.', 1, 100, 5000, 'chasseurs', 'upgrade', 'z95_torpedoes_t1', '{"explosifs":15,"circuits":10}', 'materials/icons/upgrades/torpedo.png', '{}'),
    ('tech_z95_torpedoes_t2', 'Z-95: Torpilles Proton T2', 'Amelioration avancee des torpilles.', 2, 200, 10000, 'chasseurs', 'upgrade', 'z95_torpedoes_t2', '{"explosifs":30,"circuits":20}', 'materials/icons/upgrades/torpedo.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier);

-- ============================================================================
-- TECH EDGES - DEPENDANCES DES UPGRADES
-- ============================================================================

-- V-19: Blueprint → T1 upgrades
INSERT INTO aether_tech_edges (parent_id, child_id) VALUES
    ('tech_v19_blueprint', 'tech_v19_hp_t1'),
    ('tech_v19_blueprint', 'tech_v19_armor_t1'),
    ('tech_v19_blueprint', 'tech_v19_speed_t1'),
    ('tech_v19_blueprint', 'tech_v19_cannons_t1'),
    ('tech_v19_blueprint', 'tech_v19_missiles_t1')
ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id);

-- V-19: T1 → T2 → T3
INSERT INTO aether_tech_edges (parent_id, child_id) VALUES
    ('tech_v19_hp_t1', 'tech_v19_hp_t2'),
    ('tech_v19_hp_t2', 'tech_v19_hp_t3'),

    ('tech_v19_armor_t1', 'tech_v19_armor_t2'),
    ('tech_v19_armor_t2', 'tech_v19_armor_t3'),

    ('tech_v19_speed_t1', 'tech_v19_speed_t2'),
    ('tech_v19_speed_t2', 'tech_v19_speed_t3'),

    ('tech_v19_cannons_t1', 'tech_v19_cannons_t2'),
    ('tech_v19_cannons_t2', 'tech_v19_cannons_t3'),

    ('tech_v19_missiles_t1', 'tech_v19_missiles_t2')
ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id);

-- Z-95: Blueprint → T1 upgrades
INSERT INTO aether_tech_edges (parent_id, child_id) VALUES
    ('tech_z95_blueprint', 'tech_z95_hp_t1'),
    ('tech_z95_blueprint', 'tech_z95_shield_t1'),
    ('tech_z95_blueprint', 'tech_z95_speed_t1'),
    ('tech_z95_blueprint', 'tech_z95_cannons_t1'),
    ('tech_z95_blueprint', 'tech_z95_torpedoes_t1')
ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id);

-- Z-95: T1 → T2 → T3
INSERT INTO aether_tech_edges (parent_id, child_id) VALUES
    ('tech_z95_hp_t1', 'tech_z95_hp_t2'),
    ('tech_z95_hp_t2', 'tech_z95_hp_t3'),

    ('tech_z95_shield_t1', 'tech_z95_shield_t2'),
    ('tech_z95_shield_t2', 'tech_z95_shield_t3'),

    ('tech_z95_speed_t1', 'tech_z95_speed_t2'),
    ('tech_z95_speed_t2', 'tech_z95_speed_t3'),

    ('tech_z95_cannons_t1', 'tech_z95_cannons_t2'),
    ('tech_z95_cannons_t2', 'tech_z95_cannons_t3'),

    ('tech_z95_torpedoes_t1', 'tech_z95_torpedoes_t2')
ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id);

-- ============================================================================
-- PROGRESSION INITIALE (REPUBLIC)
-- ============================================================================

-- Tous les upgrades commencent en statut 'locked'
-- Ils se deverrouilleront automatiquement quand leurs prereqs seront completes

INSERT INTO aether_research_progress (account_id, node_id, progress, status, started_at, completed_at)
VALUES
    -- V-19 Upgrades
    ('REPUBLIC', 'tech_v19_hp_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_hp_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_hp_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_armor_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_armor_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_armor_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_speed_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_speed_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_speed_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_cannons_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_cannons_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_cannons_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_missiles_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_v19_missiles_t2', 0, 'locked', NULL, NULL),

    -- Z-95 Upgrades
    ('REPUBLIC', 'tech_z95_hp_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_hp_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_hp_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_shield_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_shield_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_shield_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_speed_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_speed_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_speed_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_cannons_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_cannons_t2', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_cannons_t3', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_torpedoes_t1', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_torpedoes_t2', 0, 'locked', NULL, NULL)
ON DUPLICATE KEY UPDATE
    status = CASE
        WHEN status = 'completed' THEN 'completed'
        ELSE VALUES(status)
    END;

-- ============================================================================
-- TODO: Ajouter les autres vehicules
-- - V-Wing
-- - Y-Wing
-- - ARC-170
-- - LAAT/i
-- - LAAT/c
-- - LAAT/g
-- - TX-130 (deja fait en lua manuel)
-- - AT-TE
-- - Juggernaut
-- - BARC
-- - etc.
-- ============================================================================
