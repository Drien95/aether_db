-- ============================================================================
-- AETHER RESEARCH - SEED VEHICULES AERIENS
-- ============================================================================
-- Fichier: sql/seed_vehicles_aeriens.sql
-- Genere depuis l'analyse des addons LVS installes (Workshop)
-- Date: 08/02/2026
--
-- CONTENU:
--   1. Categories aeriennes
--   2. Definitions vehicules aeriens (6 vehicules verifies)
--   3. Tech Nodes (deblocages aeriens)
--   4. Tech Edges (dependances)
--   5. Progression initiale (REPUBLIC)
-- ============================================================================

-- ============================================================================
-- 1. CATEGORIES AERIENNES
-- ============================================================================

INSERT INTO aether_categories (id, name) VALUES
    ('chasseurs', 'Chasseurs'),
    ('transport_aerien', 'Vehicules de transport aerien')
ON DUPLICATE KEY UPDATE
    name = VALUES(name);

-- ============================================================================
-- 2. DEFINITIONS VEHICULES AERIENS
-- ============================================================================
-- Colonnes: class_id, name, category_id, type, model, icon, description,
--           weight, width, height, is_buyable, price, materials, data,
--           item_type, max_upgrade_slots, requires_tech
--
-- IMPORTANT: Les class_id correspondent aux vrais noms des entites
-- des addons Workshop installes (verifies en jeu).

-- === V-19 TORRENT (Chasseur - Deblocable) ===
-- Workshop: 3006184064
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_starfighter_v19', 'V-19 Torrent', 'chasseurs', 'vehicle',
     'models/durian/v19/v19.mdl', 'materials/icons/vehicles/v19.png',
     'Intercepteur leger de la Republique. Rapide et maniable, ideal pour les missions de patrouille et d''escorte.',
     0, 1, 1, 0, 15000, '{}',
     '{"spawn_class":"lvs_starfighter_v19","spawn_type":"lvs","base_hp":800,"base_shield":0,"base_speed":2650,"base_thrust":2650,"turn_pitch":1.2,"turn_yaw":1.2,"turn_roll":1.2,"weapons":{"cannons":{"ammo":2000,"damage":50},"dual_cannons":{"ammo":2500,"damage":280},"missiles":{"ammo":6,"damage":800}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === Z-95 HEADHUNTER (Chasseur - Deblocable) ===
-- Workshop: 3027336722
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_z-95_headhunter', 'Z-95 Headhunter', 'chasseurs', 'vehicle',
     'models/light/lpr_z-95_headhunter.mdl', 'materials/icons/vehicles/z95.png',
     'Chasseur monoplace reconnu pour sa vitesse et sa puissance de feu. Un classique de la flotte republicaine.',
     0, 1, 1, 0, 12000, '{}',
     '{"spawn_class":"lvs_z-95_headhunter","spawn_type":"lvs","base_hp":600,"base_shield":100,"base_speed":3000,"base_thrust":3000,"turn_pitch":2,"turn_yaw":3,"turn_roll":1,"weapons":{"dual_lasers":{"ammo":400,"damage":40},"proton_torpedoes":{"ammo":8}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === V-WING (Chasseur - Deblocable) ===
-- Workshop: 3261154390
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_vwing_advanced', 'Alpha-3 Nimbus V-Wing', 'chasseurs', 'vehicle',
     'models/vanilla/vwing/vwing_landed.mdl', 'materials/icons/vehicles/vwing.png',
     'Intercepteur rapide avec bouclier solide. Mecanique de foils: ailes repliees = combat degrade, ailes ouvertes = performance nominale.',
     0, 1, 1, 0, 25000, '{}',
     '{"spawn_class":"lvs_vwing_advanced","spawn_type":"lvs","base_hp":1000,"base_shield":600,"base_speed":2850,"base_thrust":2850,"turn_pitch":1.5,"turn_yaw":1.5,"turn_roll":1.5,"weapons":{"quad_lasers":{"ammo":3000,"damage":80,"delay":0.07},"concussion_missiles":{"ammo":3,"damage":1200},"turbo":true},"special":{"foils":true}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === LAAT/i SPACE (Transport - Achetable) ===
-- Workshop: 3238211247
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_space_laat', 'LAAT/i Gunship', 'transport_aerien', 'vehicle',
     'models/fisher/laat/laatspace.mdl', 'materials/icons/vehicles/laat.png',
     'Transport de troupes lourdement arme. Capacite de transport elevee avec armement defensif complet.',
     0, 1, 1, 1, 75000, '{}',
     '{"spawn_class":"lvs_space_laat","spawn_type":"lvs","base_hp":6000,"base_shield":0,"base_speed":2650,"base_thrust":2650,"turn_pitch":1,"turn_yaw":1,"turn_roll":1.25,"capacity":20,"weapons":{"front_cannons":{"ammo":600,"damage":60},"ball_turrets":true,"missiles":{"ammo":10,"damage":1250},"rockets":{"ammo":40,"damage":1250}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === Y-WING (Bombardier - Deblocable) ===
-- Workshop: 2933864153
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_starfighter_ywing', 'BTL-B Y-Wing', 'chasseurs', 'vehicle',
     'models/ywing/BTL-B_Y-Wing.mdl', 'materials/icons/vehicles/ywing.png',
     'Bombardier biplace de la Republique. Lent mais devastateur avec ses torpilles et bombes proton.',
     0, 1, 1, 0, 45000, '{}',
     '{"spawn_class":"lvs_starfighter_ywing","spawn_type":"lvs","base_hp":400,"base_shield":100,"base_speed":2350,"base_thrust":2350,"turn_pitch":1,"turn_yaw":1,"turn_roll":0.75,"crew":2,"bomber":true,"weapons":{"cannons":{"ammo":1200,"damage":40},"proton_torpedoes":{"ammo":12},"proton_bombs":{"ammo":10},"rear_turret":true}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === LAAT/g HEAVY GUNSHIP (Support lourd - Deblocable) ===
-- Workshop: 3047547785
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_repulsorlift_gunship_heavy', 'LAAT/g Heavy Gunship', 'transport_aerien', 'vehicle',
     'models/blu/laatg.mdl', 'materials/icons/vehicles/laatg.png',
     'Canonniere lourde de support rapproche. Lente mais extremement bien armee avec 5 positions de tir.',
     0, 1, 1, 0, 150000, '{}',
     '{"spawn_class":"lvs_repulsorlift_gunship_heavy","spawn_type":"lvs","base_hp":7500,"base_shield":0,"base_speed":275,"base_thrust":275,"turn_pitch":0.3,"turn_yaw":0.3,"turn_roll":0.3,"crew":5,"heavy_support":true,"weapons":{"front_cannons":{"ammo":600,"damage":40},"missiles":{"ammo":20},"ball_turrets":true,"wing_turrets":true}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- ============================================================================
-- 3. TECH NODES (Arbre technologique - deblocages aeriens)
-- ============================================================================

-- Noeud racine aviation
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_aviation_base', 'Fondamentaux de l''Aviation',
     'Formation de base pour les pilotes et mecaniciens de la flotte aerienne.',
     1, 100, 1000, 'aviation', 'unlock', 'aviation_license',
     '{"fer":20,"circuits":10}', 'materials/icons/tech/aviation.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- V-19 Torrent Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_v19_blueprint', 'Plans V-19 Torrent',
     'Debloque l''achat de l''intercepteur V-19. Leger et maniable, ideal pour la patrouille.',
     0, 100, 5000, 'chasseurs', 'blueprint', 'lvs_starfighter_v19',
     '{"fer":20,"circuits":10}', 'materials/icons/tech/v19.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- Z-95 Headhunter Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_z95_blueprint', 'Plans Z-95 Headhunter',
     'Debloque l''achat du Z-95. Chasseur rapide avec une puissance de feu equilibree.',
     0, 100, 5000, 'chasseurs', 'blueprint', 'lvs_z-95_headhunter',
     '{"fer":20,"circuits":10}', 'materials/icons/tech/z95.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- V-Wing Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_vwing_blueprint', 'Plans Alpha-3 V-Wing',
     'Debloque l''achat de l''intercepteur V-Wing. Rapide, bouclie, mecanique de foils unique.',
     0, 200, 10000, 'chasseurs', 'blueprint', 'lvs_vwing_advanced',
     '{"fer":30,"circuits":20}', 'materials/icons/tech/vwing.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- Y-Wing Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_ywing_blueprint', 'Plans BTL-B Y-Wing',
     'Debloque l''achat du bombardier Y-Wing. Ideal pour les frappes de precision et le bombardement.',
     0, 300, 15000, 'chasseurs', 'blueprint', 'lvs_starfighter_ywing',
     '{"fer":40,"circuits":25,"explosifs":20}', 'materials/icons/tech/ywing.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- LAAT/g Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_laatg_blueprint', 'Plans LAAT/g Heavy Gunship',
     'Debloque l''achat de la canonniere lourde LAAT/g. Plateforme de support aerien devastatrice.',
     0, 600, 50000, 'transport_aerien', 'blueprint', 'lvs_repulsorlift_gunship_heavy',
     '{"fer":80,"circuits":50,"durasteel":40}', 'materials/icons/tech/laatg.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ARC-170 Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_arc170_blueprint', 'Plans ARC-170 Fighter',
     'Debloque l''achat du bombardier lourd ARC-170. Chasseur d''escorte longue distance avec equipage de 3.',
     0, 300, 15000, 'chasseurs', 'blueprint', 'lvs_starfighter_arc170',
     '{"fer":40,"circuits":25,"durasteel":20}', 'materials/icons/tech/arc170.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- LAAT/c Blueprint
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_laatc_blueprint', 'Plans LAAT/c Dropship',
     'Debloque l''achat du transporteur lourd LAAT/c. Capacite de transport de vehicules lourds avec systeme grabber.',
     0, 400, 25000, 'transport_aerien', 'blueprint', 'lvs_repulsorlift_dropship',
     '{"fer":50,"circuits":30,"durasteel":25}', 'materials/icons/tech/laatc.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ============================================================================
-- 4. TECH EDGES (Dependances aeriens)
-- ============================================================================
-- NOUVELLE STRUCTURE: Aucune dependance entre blueprints de vehicules.
-- Chaque vehicule est debloquable independamment.
-- Les upgrades seront lies a leur blueprint respectif (voir seed_upgrades_vehicles.sql)

-- Note: Plus de dépendances entre blueprints - tous indépendants

-- ============================================================================
-- 5. PROGRESSION INITIALE (REPUBLIC - noeuds aeriens)
-- ============================================================================

INSERT INTO aether_research_progress (account_id, node_id, progress, status, started_at, completed_at)
VALUES
    ('REPUBLIC', 'tech_aviation_base', 0, 'available', NULL, NULL),
    ('REPUBLIC', 'tech_v19_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z95_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_vwing_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_ywing_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_laatg_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_arc170_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_laatc_blueprint', 0, 'locked', NULL, NULL)
ON DUPLICATE KEY UPDATE
    status = CASE
        WHEN status = 'completed' THEN status
        ELSE VALUES(status)
    END;

-- ============================================================================
-- VERIFICATION
-- ============================================================================

SELECT 'Vehicules aeriens' AS type, COUNT(*) AS count FROM aether_definitions
WHERE class_id IN ('lvs_starfighter_v19', 'lvs_z-95_headhunter', 'lvs_vwing_advanced', 'lvs_space_laat', 'lvs_starfighter_ywing', 'lvs_repulsorlift_gunship_heavy');

SELECT 'Tech nodes aviation' AS type, COUNT(*) AS count FROM aether_tech_nodes
WHERE id IN ('tech_aviation_base', 'tech_v19_blueprint', 'tech_z95_blueprint', 'tech_vwing_blueprint', 'tech_ywing_blueprint', 'tech_laatg_blueprint', 'tech_arc170_blueprint', 'tech_laatc_blueprint');

-- ============================================================================
-- FIN SEED VEHICULES AERIENS
-- ============================================================================
