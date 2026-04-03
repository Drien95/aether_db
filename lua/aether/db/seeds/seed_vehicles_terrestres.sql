-- ============================================================================
-- AETHER RESEARCH - SEED VEHICULES TERRESTRES
-- ============================================================================
-- Fichier: sql/seed_vehicles_terrestres.sql
-- Genere depuis l'analyse des addons LVS/LFS installes (Workshop)
-- Date: 08/02/2026
--
-- CONTENU:
--   1. Categories terrestres
--   2. Definitions vehicules terrestres (9 vehicules verifies)
--   3. Tech Nodes (deblocages terrestres)
--   4. Tech Edges (dependances)
--   5. Progression initiale (REPUBLIC)
--
-- NOTE: Tous les vehicules sont en blueprint (is_buyable = 0).
-- NOTE: L'ISP a 4 variantes (random/laser/missiles/turrets) mais on seed
--       uniquement la variante de base (random) pour simplifier.
-- NOTE: Le BARC Medical est une variante cosmetique, pas seedee separement.
-- NOTE: L'AT-TE utilise le framework LFS (pas LVS), spawn_type = "lfs".
-- ============================================================================

-- ============================================================================
-- 1. CATEGORIES TERRESTRES
-- ============================================================================

INSERT INTO aether_categories (id, name) VALUES
    ('chars', 'Chars / Blindes'),
    ('marcheurs', 'Marcheurs'),
    ('reconnaissance', 'Vehicules de reconnaissance'),
    ('logistique', 'Vehicules de logistique')
ON DUPLICATE KEY UPDATE
    name = VALUES(name);

-- ============================================================================
-- 2. DEFINITIONS VEHICULES TERRESTRES
-- ============================================================================
-- IMPORTANT: Les class_id correspondent aux vrais noms des entites
-- des addons Workshop installes (verifies dans le code source).
-- Tous les vehicules sont en blueprint (is_buyable = 0, requires_tech).

-- === BARC SPEEDER (Reconnaissance - Blueprint) ===
-- Workshop: 2932912075
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_fakehover_barc', 'Republic BARC Speeder', 'reconnaissance', 'vehicle',
     'models/barc/barc.mdl', 'materials/icons/vehicles/barc.png',
     'Speeder bike rapide de reconnaissance. Arme de dual blasters. Transportable par LAAT/c.',
     0, 1, 1, 0, 8000, '{}',
     '{"spawn_class":"lvs_fakehover_barc","spawn_type":"lvs","base_hp":2700,"base_shield":0,"base_speed":950,"boost":260,"turn_rate":0.8,"weapons":{"dual_blasters":{"ammo":400,"damage":40,"delay":0.25}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === CK-6 SWOOP BIKE (Reconnaissance - Blueprint) ===
-- Workshop: 3640786315
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_fakehover_ck6_swoop', 'CK-6 Swoop Bike', 'reconnaissance', 'vehicle',
     'models/nsn/vehicles/ck6_swoop.mdl', 'materials/icons/vehicles/ck6.png',
     'Speeder ultra-rapide et agile. Turbo doublant la vitesse. Faible puissance de feu.',
     0, 1, 1, 0, 6000, '{}',
     '{"spawn_class":"lvs_fakehover_ck6_swoop","spawn_type":"lvs","base_hp":2700,"base_shield":0,"base_speed":600,"boost":600,"turn_rate":5,"weapons":{"dual_lasers":{"ammo":600,"damage":25,"delay":0.125},"turbo":true}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === TX-427 (Chars - Blueprint) ===
-- Workshop: 2976350545 (Luna's Flight School)
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lunasflightschool_niksacokica_tx-427', 'TX-427 Republic Tank', 'chars', 'vehicle',
     'models/lfs_vehicles/tx427/tx427_static.mdl', 'materials/icons/vehicles/tx427.png',
     'Hover tank biplace. Missiles, quad-blasters, canon ions lourd et repeteur laser.',
     0, 1, 1, 0, 15000, '{}',
     '{"spawn_class":"lunasflightschool_niksacokica_tx-427","spawn_type":"lfs","base_hp":3500,"base_shield":0,"base_speed":250,"boost":120,"turn_rate":0.5,"crew":2,"weapons":{"missiles":{"ammo":80,"damage":400,"delay":0.5},"quad_blasters":{"damage":36},"ion_cannon":{"damage":2000,"delay":2.5},"repeater":{"damage":36,"delay":0.07}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === TX-130 (Chars - Blueprint) ===
-- Workshop: 3261150740
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_tx130_t', 'TX-130 Fighter Tank', 'chars', 'vehicle',
     'models/tkaro/starwars/vehicle/tx130/tx130.mdl', 'materials/icons/vehicles/tx130.png',
     'Hover tank polyvalent. Canons laser, mode rapide, faisceau charge anti-vehicule et missiles lourds.',
     0, 1, 1, 0, 25000, '{}',
     '{"spawn_class":"lvs_tx130_t","spawn_type":"lvs","base_hp":4000,"base_shield":0,"base_speed":100,"boost":500,"turn_rate":1,"crew":3,"weapons":{"side_cannons":{"damage":150,"delay":0.5},"rapid_fire":{"damage":100,"delay":0.1},"charged_beam":{"damage":2000,"charge_time":12},"missiles":{"ammo":20,"damage":1500},"laser_beam":true}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === INFANTRY SUPPORT PLATFORM (Chars - Blueprint) ===
-- Workshop: 3103284883 (on seed la variante de base "Random")
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_fakehover_infantry_support_platform', 'Infantry Support Platform', 'chars', 'vehicle',
     'models/durian/isp/isp.mdl', 'materials/icons/vehicles/isp.png',
     'Plateforme hover legere avec double tourelle configurable (canons/laser/missiles). Fragile mais rapide.',
     0, 1, 1, 0, 10000, '{}',
     '{"spawn_class":"lvs_fakehover_infantry_support_platform","spawn_type":"lvs","base_hp":1000,"base_shield":0,"base_speed":500,"boost":600,"turn_rate":2,"crew":2,"weapons":{"turret_cannons":{"damage":20,"delay":0.1},"laser_beam":true,"missiles":{"damage":300,"salvo":8,"cooldown":20}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === AT-AP WALKER (Marcheurs - Blueprint) ===
-- Workshop: 2984292814
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_walker_atap', 'AT-AP Walker', 'marcheurs', 'vehicle',
     'models/sw/atot_veh/AT-AP.mdl', 'materials/icons/vehicles/atap.png',
     'Marcheur d''artillerie a 3 pattes. Canon principal devastateur en mode stationnaire + tourelle proton.',
     0, 1, 1, 0, 40000, '{}',
     '{"spawn_class":"lvs_walker_atap","spawn_type":"lvs","base_hp":6000,"base_shield":0,"walker":true,"crew":2,"weapons":{"bottom_gun":{"ammo":1000,"damage":100,"delay":0.3},"main_cannon":{"ammo":100,"damage":1000,"radius":500,"stationary_only":true},"turret_torpedoes":{"ammo":160,"delay":1}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === AT-OT WALKER (Marcheurs - Blueprint) ===
-- Workshop: 2984292814
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('lvs_walker_atot', 'AT-OT Walker', 'marcheurs', 'vehicle',
     'models/sw/atot_veh/AT-OT.mdl', 'materials/icons/vehicles/atot.png',
     'Transport ouvert lourd. 12000 HP, canons avant et arriere, rampe pour troupes.',
     0, 1, 1, 0, 60000, '{}',
     '{"spawn_class":"lvs_walker_atot","spawn_type":"lvs","base_hp":12000,"base_shield":0,"walker":true,"crew":2,"transport":true,"weapons":{"front_guns":{"ammo":1000,"damage":100,"delay":0.3},"rear_guns":{"ammo":400,"damage":100,"delay":0.3}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === AT-TE WALKER (Marcheurs - Blueprint T1) ===
-- Workshop: 2061996588 (modeles) + 1580978413 (entite) + 3111031938 (LFS base)
-- NOTE: Vehicule de base de la Republique. Tier 1 pour etre accessible rapidement.
-- NOTE: Multi-pieces (front+rear+6 jambes IK). Framework LFS, pas LVS.
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('kingpommes_lfs_atte', 'AT-TE Walker', 'marcheurs', 'vehicle',
     'models/kingpommes/starwars/atte/lfs_front.mdl', 'materials/icons/vehicles/atte.png',
     'Marcheur multi-pieces 6 pattes. 15 places, mass driver 360 degres, canons avant et arriere. Vehicule de base.',
     0, 1, 1, 0, 80000, '{}',
     '{"spawn_class":"kingpommes_lfs_atte","spawn_type":"lfs","base_hp":12000,"base_shield":0,"base_speed":150,"sprint":250,"walker":true,"multi_piece":true,"crew":15,"maintenance":{"time":20,"repair":1000},"weapons":{"front_guns":{"ammo":1000,"damage":150,"pattern":"burst4","shared_pool":true},"rear_guns":{"ammo_shared":true,"damage":150,"delay":0.3},"mass_driver":{"ammo":100,"blast_damage":600,"blast_radius":200,"bonus_vs_simfphys":1000,"bonus_vs_lfs":500,"heat_per_shot":50,"overheat":100,"cooldown_rate":30,"forced_cooldown":4,"velocity":6000,"rotation":360}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- === JUGGERNAUT TURBOTANK (Logistique - Blueprint) ===
-- Workshop: 3162829282
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data)
VALUES
    ('turbotank', 'HAVw A6 Juggernaut', 'logistique', 'vehicle',
     'models/vehicles/sky/turbotank/turbotank_s1.mdl', 'materials/icons/vehicles/juggernaut.png',
     'Forteresse mobile. 18000 HP, 4 positions de tir, salve de 20 missiles, tourelle 360 degres.',
     0, 1, 1, 0, 150000, '{}',
     '{"spawn_class":"turbotank","spawn_type":"lvs","base_hp":18000,"base_shield":0,"base_speed":650,"boost":850,"turn_rate":0.5,"crew":4,"weapons":{"front_cannons":{"ammo":300,"damage":100,"delay":0.35},"missiles":{"ammo":160,"damage":550,"salvo":20},"top_turret":{"ammo":1000,"damage":65,"delay":0.1,"angle":360},"rear_cannon":{"ammo":200,"damage":150,"delay":0.15},"side_cannon":{"ammo":1000,"damage":55,"delay":0.1}}}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data);

-- ============================================================================
-- 3. TECH NODES (Arbre technologique - deblocages terrestres)
-- ============================================================================

-- Noeud racine vehicules terrestres
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_ground_base', 'Fondamentaux Vehicules Terrestres',
     'Formation de base pour les pilotes et mecaniciens de vehicules au sol.',
     1, 100, 1000, 'terrestre', 'unlock', 'ground_license',
     '{"fer":20,"circuits":10}', 'materials/icons/tech/ground.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- AT-TE Walker Blueprint (T1 - vehicule de base)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_atte_blueprint', 'Plans AT-TE Walker',
     'Debloque le marcheur AT-TE. Vehicule de base de la Republique. 15 places, mass driver 360 degres.',
     0, 100, 10000, 'marcheurs', 'blueprint', 'kingpommes_lfs_atte',
     '{"fer":30,"circuits":15}', 'materials/icons/tech/atte.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- BARC Speeder Blueprint (T2 - leger)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_barc_blueprint', 'Plans BARC Speeder',
     'Debloque le speeder de reconnaissance BARC. Rapide et transportable.',
     0, 150, 5000, 'reconnaissance', 'blueprint', 'lvs_fakehover_barc',
     '{"fer":15,"circuits":10}', 'materials/icons/tech/barc.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- CK-6 Swoop Blueprint (T2 - leger)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_ck6_blueprint', 'Plans CK-6 Swoop Bike',
     'Debloque le speeder ultra-rapide CK-6. Le plus agile de la flotte.',
     0, 150, 4000, 'reconnaissance', 'blueprint', 'lvs_fakehover_ck6_swoop',
     '{"fer":10,"circuits":15}', 'materials/icons/tech/ck6.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- TX-427 Blueprint (T2)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_tx427_blueprint', 'Plans TX-427',
     'Debloque le hover tank TX-427. Biplace avec canon ions et repeteur.',
     0, 200, 8000, 'chars', 'blueprint', 'lunasflightschool_niksacokica_tx-427',
     '{"fer":25,"circuits":15}', 'materials/icons/tech/tx427.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ISP Blueprint (T2)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_isp_blueprint', 'Plans Infantry Support Platform',
     'Debloque la plateforme ISP. Legere mais polyvalente avec double tourelle.',
     0, 200, 6000, 'chars', 'blueprint', 'lvs_fakehover_infantry_support_platform',
     '{"fer":20,"circuits":15}', 'materials/icons/tech/isp.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- TX-130 Blueprint (T3 - plus puissant)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_tx130_blueprint', 'Plans TX-130 Fighter Tank',
     'Debloque le TX-130. Faisceau charge anti-vehicule et missiles lourds.',
     0, 400, 20000, 'chars', 'blueprint', 'lvs_tx130_t',
     '{"fer":50,"circuits":30,"durasteel":20}', 'materials/icons/tech/tx130.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- AT-AP Blueprint (T3)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_atap_blueprint', 'Plans AT-AP Walker',
     'Debloque le marcheur d''artillerie AT-AP. Canon principal devastateur.',
     0, 500, 25000, 'marcheurs', 'blueprint', 'lvs_walker_atap',
     '{"fer":60,"circuits":30,"durasteel":30}', 'materials/icons/tech/atap.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- AT-OT Blueprint (T3)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_atot_blueprint', 'Plans AT-OT Walker',
     'Debloque le transport lourd AT-OT. 12000 HP avec rampe de deploiement.',
     0, 500, 30000, 'marcheurs', 'blueprint', 'lvs_walker_atot',
     '{"fer":70,"circuits":35,"durasteel":35}', 'materials/icons/tech/atot.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- Juggernaut Blueprint (T4 - endgame)
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_juggernaut_blueprint', 'Plans HAVw A6 Juggernaut',
     'Debloque la forteresse mobile Juggernaut. 18000 HP, 4 positions de tir.',
     0, 800, 80000, 'logistique', 'blueprint', 'turbotank',
     '{"fer":100,"circuits":60,"durasteel":50,"explosifs":30}', 'materials/icons/tech/juggernaut.png', '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ============================================================================
-- 4. TECH EDGES (Dependances terrestres)
-- ============================================================================
-- NOUVELLE STRUCTURE: Aucune dependance entre blueprints de vehicules.
-- Chaque vehicule est debloquable independamment.
-- Les upgrades seront lies a leur blueprint respectif (voir seed_upgrades_vehicles.sql)

-- Note: Plus de dépendances entre blueprints - tous indépendants
-- Ancienne structure supprimée:
-- -- T1 → T2 (base deverouille les petits vehicules)
-- -- T2 → T3 (chars mènent aux chars lourds et marcheurs)
-- -- T3 → T4 (marcheurs/chars lourds mènent au juggernaut)

-- ============================================================================
-- 5. PROGRESSION INITIALE (REPUBLIC - noeuds terrestres)
-- ============================================================================

INSERT INTO aether_research_progress (account_id, node_id, progress, status, started_at, completed_at)
VALUES
    ('REPUBLIC', 'tech_ground_base', 0, 'available', NULL, NULL),
    ('REPUBLIC', 'tech_atte_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_barc_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_ck6_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_tx427_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_isp_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_tx130_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_atap_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_atot_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_juggernaut_blueprint', 0, 'locked', NULL, NULL)
ON DUPLICATE KEY UPDATE
    status = CASE
        WHEN status = 'completed' THEN status
        ELSE VALUES(status)
    END;

-- ============================================================================
-- VERIFICATION
-- ============================================================================

SELECT 'Vehicules terrestres' AS type, COUNT(*) AS count FROM aether_definitions
WHERE class_id IN ('lvs_fakehover_barc', 'lvs_fakehover_ck6_swoop', 'lunasflightschool_niksacokica_tx-427', 'lvs_tx130_t', 'lvs_fakehover_infantry_support_platform', 'lvs_walker_atap', 'lvs_walker_atot', 'kingpommes_lfs_atte', 'turbotank');

SELECT 'Tech nodes terrestres' AS type, COUNT(*) AS count FROM aether_tech_nodes
WHERE id IN ('tech_ground_base', 'tech_atte_blueprint', 'tech_barc_blueprint', 'tech_ck6_blueprint', 'tech_tx427_blueprint', 'tech_isp_blueprint', 'tech_tx130_blueprint', 'tech_atap_blueprint', 'tech_atot_blueprint', 'tech_juggernaut_blueprint');

-- ============================================================================
-- FIN SEED VEHICULES TERRESTRES
-- ============================================================================
