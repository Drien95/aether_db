-- ============================================================================
-- AETHER RESEARCH - SEED ARMES ARC9
-- ============================================================================
-- Fichier: sql/seed_weapons.sql
-- Genere depuis l'analyse des addons ARC9 installes (Workshop)
-- Date: 08/02/2026
--
-- CONTENU:
--   1. Categories armes (9 categories)
--   2. Definitions armes (20 armes verifiees)
--   3. Tech Nodes (78 noeuds: racine + modes de tir + blueprints)
--   4. Tech Edges (dependances lineaires par paire)
--   5. Progression initiale (REPUBLIC)
--
-- SOURCES ADDONS:
--   - arc9-republic-essentials-v1-1 (14 armes)
--   - arc9-galactic-expansion-volume1-v1-2 (4 armes)
--   - arc9-explosive-expansion-v1-2 (2 lanceurs)
--
-- MODES DE TIR (swrp_firemodes):
--   - arc9_ammo_scatter (Scatter Mode)
--   - arc9_ammo_le (Long Engagements)
--   - arc9_ammo_charged (Charged Mode)
--   - arc9_ammo_at (Anti-Tank Mode)
--
-- MODES ROCKET (swrp_ammotypes_rocket):
--   - arc9_ammo_rocket_saclos (SACLOS tracking)
--   - arc9_ammo_rocket_gas (Toxic Gas)
--   - arc9_ammo_rocket_cluster (Cluster)
--
-- MODES ROCKET PLX (swrp_ammotypes_rocket_plx):
--   - arc9_ammo_rocket_plxpem (EMP)
--
-- REGLES:
--   - 10 paires de progression (1ere arme gratuite -> modes -> 2eme arme)
--   - Tous les modes de tir doivent etre debloques avant de passer a l'arme suivante
--   - item_type = 'weapon' pour toutes les armes
--   - spawn_type = 'arc9' dans le champ data
-- ============================================================================

-- ============================================================================
-- 1. CATEGORIES ARMES
-- ============================================================================

INSERT INTO aether_categories (id, name) VALUES
    ('snipers', 'Fusils de precision'),
    ('carabines', 'Carabines'),
    ('fusils', 'Fusils'),
    ('fusils_pompe', 'Fusils a pompe'),
    ('blasters_legers', 'Blasters legers'),
    ('smgs', 'Pistolets mitrailleurs'),
    ('armes_lourdes', 'Armes lourdes'),
    ('lanceurs', 'Lance-roquettes'),
    ('pistolets', 'Pistolets')
ON DUPLICATE KEY UPDATE
    name = VALUES(name);

-- ============================================================================
-- 2. DEFINITIONS ARMES (20 armes)
-- ============================================================================
-- IMPORTANT: Les class_id correspondent aux vrais noms SWEP des addons ARC9.
-- Les 1eres armes de chaque paire sont achetables (is_buyable=1, requires_tech=NULL).
-- Les 2emes armes sont des blueprints (is_buyable=0, requires_tech=tech node).
-- item_type='weapon' pour toutes les armes.

-- ===================== SNIPERS =====================

-- === DC-15X (Sniper - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc15x', 'DC-15X', 'snipers', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc15x.mdl', NULL,
     'Fusil de precision longue portee. Haute puissance, cadence lente. Arme standard des tireurs d''elite clones.',
     0, 2, 1, 0, 3000, '{}',
     '{"spawn_class":"arc9_k_dc15x","spawn_type":"arc9","damage_max":135,"damage_min":98,"rpm":180,"clip":25,"firemodes":["semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc15x_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === NT-242 (Sniper - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_galactic_nt242', 'NT-242', 'snipers', 'weapon',
     'models/arc9/kraken/galactic/v_nt242.mdl', NULL,
     'Fusil de precision avance. Degats superieurs, cadence plus lente. Munitions Purple Tibanna, traceur vert.',
     0, 2, 1, 0, 10000, '{}',
     '{"spawn_class":"arc9_galactic_nt242","spawn_type":"arc9","damage_max":202,"damage_min":105,"rpm":100,"clip":20,"firemodes":["semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_nt242_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== CARABINES =====================

-- === DC-15S (Carabine - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc15s', 'DC-15S', 'carabines', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc15s.mdl', NULL,
     'Carabine standard des clones. Polyvalente, bonne cadence. Arme de base pour l''infanterie.',
     0, 2, 1, 0, 1500, '{}',
     '{"spawn_class":"arc9_k_dc15s","spawn_type":"arc9","damage_max":33,"damage_min":29,"rpm":300,"clip":45,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc15s_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === DC-15SE (Carabine - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_galactic_dc15se', 'DC-15SE', 'carabines', 'weapon',
     'models/arc9/kraken/galactic/v_dc15.mdl', NULL,
     'Carabine courte portee amelioree. Degats superieurs a la DC-15S, cadence legerement reduite.',
     0, 2, 1, 0, 4000, '{}',
     '{"spawn_class":"arc9_galactic_dc15se","spawn_type":"arc9","damage_max":54,"damage_min":39,"rpm":270,"clip":35,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc15se_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== FUSILS =====================

-- === DC-15A (Fusil - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc15a', 'DC-15A', 'fusils', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc15a.mdl', NULL,
     'Fusil d''assaut standard. Haute cadence de tir, chargeur genereux. Arme polyvalente.',
     0, 2, 1, 0, 2000, '{}',
     '{"spawn_class":"arc9_k_dc15a","spawn_type":"arc9","damage_max":33,"damage_min":29,"rpm":475,"clip":55,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc15a_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === DC-15LE (Fusil - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc15le', 'DC-15LE', 'fusils', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc15le.mdl', NULL,
     'Fusil lourd ameliore. Degats superieurs, meme cadence. Concu pour les engagements prolonges.',
     0, 2, 1, 0, 5000, '{}',
     '{"spawn_class":"arc9_k_dc15le","spawn_type":"arc9","damage_max":56,"damage_min":32,"rpm":475,"clip":35,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc15le_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== FUSILS A POMPE =====================

-- === DP-23 (Shotgun - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dp23', 'DP-23', 'fusils_pompe', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dp23.mdl', NULL,
     'Blaster a dispersion standard. 8 projectiles par tir, efficace a courte portee.',
     0, 2, 1, 0, 1000, '{}',
     '{"spawn_class":"arc9_k_dp23","spawn_type":"arc9","damage_max":18,"damage_min":11,"rpm":180,"clip":30,"num":8,"firemodes":["semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dp23_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === SB-2 (Shotgun - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_sb2', 'SB-2', 'fusils_pompe', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_sb2.mdl', NULL,
     'Blaster a dispersion a pompe. Degats superieurs au DP-23, action manuelle, chargeur reduit.',
     0, 2, 1, 0, 3000, '{}',
     '{"spawn_class":"arc9_k_sb2","spawn_type":"arc9","damage_max":28,"damage_min":16,"rpm":220,"clip":15,"num":8,"firemodes":["semi"],"ammo":"ar2","manual_action":true,"attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_sb2_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== BLASTERS LEGERS =====================

-- === DP-24 (Blaster leger - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dp24', 'DP-24', 'blasters_legers', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dp24.mdl', NULL,
     'Blaster leger polyvalent. Bonne cadence et grand chargeur, faibles degats.',
     0, 2, 1, 0, 1500, '{}',
     '{"spawn_class":"arc9_k_dp24","spawn_type":"arc9","damage_max":29,"damage_min":22,"rpm":378,"clip":65,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dp24_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === E-9 (Blaster leger - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_e9', 'E-9', 'blasters_legers', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_e9.mdl', NULL,
     'Blaster polyvalent ameliore. Degats superieurs au DP-24, cadence moderee.',
     0, 2, 1, 0, 4000, '{}',
     '{"spawn_class":"arc9_k_e9","spawn_type":"arc9","damage_max":46,"damage_min":33,"rpm":302,"clip":50,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_e9_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== PISTOLETS MITRAILLEURS =====================

-- === CR-2 (SMG - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_galactic_cr2', 'CR-2', 'smgs', 'weapon',
     'models/arc9/kraken/galactic/v_cr2.mdl', NULL,
     'Pistolet mitrailleur rapide. Tres haute cadence, faibles degats par tir. Traceur vert.',
     0, 1, 1, 0, 1500, '{}',
     '{"spawn_class":"arc9_galactic_cr2","spawn_type":"arc9","damage_max":20,"damage_min":15,"rpm":680,"clip":60,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_cr2_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === CR-2C (SMG - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_galactic_cr2c', 'CR-2C', 'smgs', 'weapon',
     'models/arc9/kraken/galactic/v_cr2c.mdl', NULL,
     'Pistolet mitrailleur ameliore. Degats superieurs au CR-2, meme cadence.',
     0, 1, 1, 0, 4000, '{}',
     '{"spawn_class":"arc9_galactic_cr2c","spawn_type":"arc9","damage_max":27,"damage_min":19,"rpm":680,"clip":55,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_cr2c_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== ARMES LOURDES =====================

-- === DLT-16 (Heavy - Standard 41st) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_galactic_dlt16', 'DLT-16', 'armes_lourdes', 'weapon',
     'models/arc9/kraken/galactic/v_dlt16.mdl', NULL,
     'Fusil de sniper lourd. Haute puissance, semi-automatique. Arme standard des tireurs d''elite du 41st.',
     0, 2, 1, 0, 6000, '{}',
     '{"spawn_class":"arc9_galactic_dlt16","spawn_type":"arc9","damage_max":120,"damage_min":85,"rpm":150,"clip":7,"firemodes":["semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, NULL)
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === Z-6 Rotary Cannon (Heavy - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_z6', 'Z-6 Rotary Cannon', 'armes_lourdes', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_z6.mdl', NULL,
     'Canon rotatif lourd. Haute cadence et gros chargeur, delai de mise en rotation 0.45s, surchauffe.',
     0, 2, 1, 0, 5000, '{}',
     '{"spawn_class":"arc9_k_z6","spawn_type":"arc9","damage_max":39,"damage_min":28,"rpm":545,"clip":200,"firemodes":["auto","semi"],"ammo":"ar2","trigger_delay":0.45,"overheat_capacity":65,"attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_z6_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === Z-6 Advanced (Heavy - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_z6adv', 'Z-6 Advanced', 'armes_lourdes', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_z6adv.mdl', NULL,
     'Canon rotatif lourd ameliore. Cadence et degats superieurs, meilleure gestion thermique.',
     0, 2, 1, 0, 12000, '{}',
     '{"spawn_class":"arc9_k_z6adv","spawn_type":"arc9","damage_max":44,"damage_min":29,"rpm":700,"clip":200,"firemodes":["auto","semi"],"ammo":"ar2","trigger_delay":0.45,"overheat_capacity":75,"attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_z6adv_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== LANCE-ROQUETTES =====================

-- === RPS-6 (Launcher - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_launcher_rps6_republic', 'RPS-6', 'lanceurs', 'weapon',
     'models/arc9/kraken/sw/explosives/v_rps6_republic.mdl', NULL,
     'Lance-roquettes standard. 1000 degats max, 1 roquette par chargeur. Doit viser pour tirer.',
     0, 2, 1, 0, 8000, '{}',
     '{"spawn_class":"arc9_k_launcher_rps6_republic","spawn_type":"arc9","damage_max":1000,"damage_min":500,"rpm":300,"clip":1,"firemodes":["semi"],"ammo":"RPG_Round","shoot_ent":"arc9_rocket_rps","attachment_slot":"swrp_ammotypes_rocket"}',
     'weapon', 0, 'tech_rps6_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === PLX-1 (Launcher - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_launcher_plx1_republic', 'PLX-1', 'lanceurs', 'weapon',
     'models/arc9/kraken/sw/explosives/v_plx1_republic.mdl', NULL,
     'Lance-roquettes a guidage avance. Systeme lock-on ami/ennemi, modes attaque sol et attaque haute.',
     0, 2, 1, 0, 20000, '{}',
     '{"spawn_class":"arc9_k_launcher_plx1_republic","spawn_type":"arc9","rpm":300,"clip":1,"firemodes":["lock_on","lock_off"],"ammo":"RPG_Round","shoot_ent":"arc9_rocket_plx1","lock_on":true,"attachment_slot":"swrp_ammotypes_rocket_plx"}',
     'weapon', 0, 'tech_plx1_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ===================== PISTOLETS =====================

-- === DC-17 (Pistolet - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc17', 'DC-17', 'pistolets', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc17.mdl', NULL,
     'Pistolet blaster standard des clones. Fiable, semi-automatique.',
     0, 1, 1, 0, 500, '{}',
     '{"spawn_class":"arc9_k_dc17","spawn_type":"arc9","damage_max":38,"damage_min":22,"rpm":200,"clip":22,"firemodes":["semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc17_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === DC-17sa (Pistolet - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc17sa', 'DC-17sa', 'pistolets', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc17sa.mdl', NULL,
     'Pistolet blaster ameliore. Degats superieurs, mode automatique, cadence plus elevee.',
     0, 1, 1, 0, 2000, '{}',
     '{"spawn_class":"arc9_k_dc17sa","spawn_type":"arc9","damage_max":54,"damage_min":22,"rpm":320,"clip":23,"firemodes":["auto","semi"],"ammo":"ar2","attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dc17sa_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === Akimbo DC-17 (Pistolet Akimbo - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc17_akimbo', 'Akimbo DC-17', 'pistolets', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc17_akimbo.mdl', NULL,
     'Double DC-17. Chargeur double, rendu 3P TFA. Semi-automatique.',
     0, 1, 1, 0, 1000, '{}',
     '{"spawn_class":"arc9_k_dc17_akimbo","spawn_type":"arc9","damage_max":38,"damage_min":22,"rpm":200,"clip":44,"firemodes":["semi"],"ammo":"ar2","akimbo":true,"attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dualdc17_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- === Akimbo DC-17sa (Pistolet Akimbo - BLUEPRINT) ===
INSERT INTO aether_definitions
    (class_id, name, category_id, type, model, icon, description,
     weight, width, height, is_buyable, price, materials, data,
     item_type, max_upgrade_slots, requires_tech)
VALUES
    ('arc9_k_dc17sa_akimbo', 'Akimbo DC-17sa', 'pistolets', 'weapon',
     'models/arc9/kraken/republic-arsenal/v_dc17sa_akimbo.mdl', NULL,
     'Double DC-17sa. Degats superieurs, mode automatique, chargeur double.',
     0, 1, 1, 0, 3000, '{}',
     '{"spawn_class":"arc9_k_dc17sa_akimbo","spawn_type":"arc9","damage_max":54,"damage_min":22,"rpm":320,"clip":46,"firemodes":["auto","semi"],"ammo":"ar2","akimbo":true,"attachment_slot":"swrp_firemodes"}',
     'weapon', 0, 'tech_dualdc17sa_blueprint')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), category_id = VALUES(category_id), description = VALUES(description),
    is_buyable = VALUES(is_buyable), price = VALUES(price), data = VALUES(data),
    item_type = VALUES(item_type), requires_tech = VALUES(requires_tech);

-- ============================================================================
-- 3. TECH NODES (Arbre technologique - deblocages armes)
-- ============================================================================

-- Noeud racine armes
INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_weapons_base', 'Fondamentaux Armement',
     'Formation de base pour la modification et l''amelioration des armes blaster.',
     1, 50, 500, 'armes', 'unlock', 'weapons_license',
     '{"tibanna":5,"circuits":3}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== BLUEPRINTS ARMES DE BASE =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dc15x_blueprint', 'Plans DC-15X',
     'Debloque le fusil de precision DC-15X. Arme standard des tireurs d''elite clones.',
     0, 100, 2000, 'snipers', 'blueprint', 'arc9_k_dc15x',
     '{"durasteel":10,"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15s_blueprint', 'Plans DC-15S',
     'Debloque la carabine DC-15S. Arme polyvalente de base pour l''infanterie.',
     0, 75, 1000, 'carabines', 'blueprint', 'arc9_k_dc15s',
     '{"durasteel":8,"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15a_blueprint', 'Plans DC-15A',
     'Debloque le fusil d''assaut DC-15A. Haute cadence de tir et chargeur genereux.',
     0, 100, 1500, 'fusils', 'blueprint', 'arc9_k_dc15a',
     '{"durasteel":10,"tibanna":7,"circuits":5}', NULL, '{}'),
    ('tech_dp23_blueprint', 'Plans DP-23',
     'Debloque le blaster a dispersion DP-23. Efficace a courte portee.',
     0, 75, 800, 'fusils_pompe', 'blueprint', 'arc9_k_dp23',
     '{"durasteel":8,"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp24_blueprint', 'Plans DP-24',
     'Debloque le blaster leger DP-24. Polyvalent avec grand chargeur.',
     0, 75, 1000, 'blasters_legers', 'blueprint', 'arc9_k_dp24',
     '{"durasteel":8,"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_cr2_blueprint', 'Plans CR-2',
     'Debloque le pistolet mitrailleur CR-2. Tres haute cadence.',
     0, 75, 1000, 'smgs', 'blueprint', 'arc9_galactic_cr2',
     '{"durasteel":8,"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_z6_blueprint', 'Plans Z-6 Rotary Cannon',
     'Debloque le canon rotatif lourd Z-6. Haute cadence avec surchauffe.',
     0, 150, 4000, 'armes_lourdes', 'blueprint', 'arc9_k_z6',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_rps6_blueprint', 'Plans RPS-6',
     'Debloque le lance-roquettes RPS-6. Standard pour destruction vehicule.',
     0, 150, 6000, 'lanceurs', 'blueprint', 'arc9_k_launcher_rps6_republic',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_dc17_blueprint', 'Plans DC-17',
     'Debloque le pistolet blaster DC-17. Arme de poing standard des clones.',
     0, 50, 400, 'pistolets', 'blueprint', 'arc9_k_dc17',
     '{"durasteel":5,"tibanna":3,"circuits":2}', NULL, '{}'),
    ('tech_dualdc17_blueprint', 'Plans Akimbo DC-17',
     'Debloque les Akimbo DC-17. Double pistolet pour tir rapide.',
     0, 75, 800, 'pistolets', 'blueprint', 'arc9_k_dc17_akimbo',
     '{"durasteel":8,"tibanna":5,"circuits":3}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== SNIPERS: DC-15X modes -> NT-242 blueprint -> NT-242 modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dc15x_scatter', 'DC-15X: Mode Scatter',
     'Debloque le mode Scatter pour le DC-15X. Convertit en tir a dispersion.',
     1, 50, 500, 'snipers', 'firemode', 'arc9_k_dc15x:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15x_le', 'DC-15X: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-15X. Ameliore la portee.',
     1, 50, 500, 'snipers', 'firemode', 'arc9_k_dc15x:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15x_charged', 'DC-15X: Mode Charged',
     'Debloque le mode Charged pour le DC-15X. Tir charge a haute puissance.',
     1, 50, 500, 'snipers', 'firemode', 'arc9_k_dc15x:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15x_at', 'DC-15X: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-15X. Efficace contre les vehicules.',
     1, 50, 500, 'snipers', 'firemode', 'arc9_k_dc15x:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_nt242_blueprint', 'Plans NT-242',
     'Debloque le fusil de precision NT-242. Degats superieurs au DC-15X.',
     2, 200, 8000, 'snipers', 'blueprint', 'arc9_galactic_nt242',
     '{"durasteel":20,"tibanna":15,"circuits":10}', NULL, '{}'),
    ('tech_nt242_scatter', 'NT-242: Mode Scatter',
     'Debloque le mode Scatter pour le NT-242.',
     3, 75, 750, 'snipers', 'firemode', 'arc9_galactic_nt242:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_nt242_le', 'NT-242: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le NT-242.',
     3, 75, 750, 'snipers', 'firemode', 'arc9_galactic_nt242:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_nt242_charged', 'NT-242: Mode Charged',
     'Debloque le mode Charged pour le NT-242.',
     3, 75, 750, 'snipers', 'firemode', 'arc9_galactic_nt242:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_nt242_at', 'NT-242: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le NT-242.',
     3, 75, 750, 'snipers', 'firemode', 'arc9_galactic_nt242:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== CARABINES: DC-15S modes -> DC-15SE blueprint -> DC-15SE modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dc15s_scatter', 'DC-15S: Mode Scatter',
     'Debloque le mode Scatter pour le DC-15S.',
     1, 50, 500, 'carabines', 'firemode', 'arc9_k_dc15s:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15s_le', 'DC-15S: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-15S.',
     1, 50, 500, 'carabines', 'firemode', 'arc9_k_dc15s:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15s_charged', 'DC-15S: Mode Charged',
     'Debloque le mode Charged pour le DC-15S.',
     1, 50, 500, 'carabines', 'firemode', 'arc9_k_dc15s:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15s_at', 'DC-15S: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-15S.',
     1, 50, 500, 'carabines', 'firemode', 'arc9_k_dc15s:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15se_blueprint', 'Plans DC-15SE',
     'Debloque la carabine DC-15SE. Degats superieurs a la DC-15S.',
     2, 150, 4000, 'carabines', 'blueprint', 'arc9_galactic_dc15se',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_dc15se_scatter', 'DC-15SE: Mode Scatter',
     'Debloque le mode Scatter pour le DC-15SE.',
     3, 75, 750, 'carabines', 'firemode', 'arc9_galactic_dc15se:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15se_le', 'DC-15SE: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-15SE.',
     3, 75, 750, 'carabines', 'firemode', 'arc9_galactic_dc15se:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15se_charged', 'DC-15SE: Mode Charged',
     'Debloque le mode Charged pour le DC-15SE.',
     3, 75, 750, 'carabines', 'firemode', 'arc9_galactic_dc15se:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15se_at', 'DC-15SE: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-15SE.',
     3, 75, 750, 'carabines', 'firemode', 'arc9_galactic_dc15se:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== FUSILS: DC-15A modes -> DC-15LE blueprint -> DC-15LE modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dc15a_scatter', 'DC-15A: Mode Scatter',
     'Debloque le mode Scatter pour le DC-15A.',
     1, 50, 500, 'fusils', 'firemode', 'arc9_k_dc15a:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15a_le', 'DC-15A: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-15A.',
     1, 50, 500, 'fusils', 'firemode', 'arc9_k_dc15a:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15a_charged', 'DC-15A: Mode Charged',
     'Debloque le mode Charged pour le DC-15A.',
     1, 50, 500, 'fusils', 'firemode', 'arc9_k_dc15a:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15a_at', 'DC-15A: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-15A.',
     1, 50, 500, 'fusils', 'firemode', 'arc9_k_dc15a:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc15le_blueprint', 'Plans DC-15LE',
     'Debloque le fusil DC-15LE. Degats superieurs au DC-15A.',
     2, 150, 5000, 'fusils', 'blueprint', 'arc9_k_dc15le',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_dc15le_scatter', 'DC-15LE: Mode Scatter',
     'Debloque le mode Scatter pour le DC-15LE.',
     3, 75, 750, 'fusils', 'firemode', 'arc9_k_dc15le:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15le_le', 'DC-15LE: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-15LE.',
     3, 75, 750, 'fusils', 'firemode', 'arc9_k_dc15le:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15le_charged', 'DC-15LE: Mode Charged',
     'Debloque le mode Charged pour le DC-15LE.',
     3, 75, 750, 'fusils', 'firemode', 'arc9_k_dc15le:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc15le_at', 'DC-15LE: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-15LE.',
     3, 75, 750, 'fusils', 'firemode', 'arc9_k_dc15le:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== FUSILS A POMPE: DP-23 modes -> SB-2 blueprint -> SB-2 modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dp23_scatter', 'DP-23: Mode Scatter',
     'Debloque le mode Scatter pour le DP-23.',
     1, 50, 500, 'fusils_pompe', 'firemode', 'arc9_k_dp23:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp23_le', 'DP-23: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DP-23.',
     1, 50, 500, 'fusils_pompe', 'firemode', 'arc9_k_dp23:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp23_charged', 'DP-23: Mode Charged',
     'Debloque le mode Charged pour le DP-23.',
     1, 50, 500, 'fusils_pompe', 'firemode', 'arc9_k_dp23:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp23_at', 'DP-23: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DP-23.',
     1, 50, 500, 'fusils_pompe', 'firemode', 'arc9_k_dp23:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_sb2_blueprint', 'Plans SB-2',
     'Debloque le fusil a pompe SB-2. Plus puissant que le DP-23.',
     2, 150, 3000, 'fusils_pompe', 'blueprint', 'arc9_k_sb2',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_sb2_scatter', 'SB-2: Mode Scatter',
     'Debloque le mode Scatter pour le SB-2.',
     3, 75, 750, 'fusils_pompe', 'firemode', 'arc9_k_sb2:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_sb2_le', 'SB-2: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le SB-2.',
     3, 75, 750, 'fusils_pompe', 'firemode', 'arc9_k_sb2:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_sb2_charged', 'SB-2: Mode Charged',
     'Debloque le mode Charged pour le SB-2.',
     3, 75, 750, 'fusils_pompe', 'firemode', 'arc9_k_sb2:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_sb2_at', 'SB-2: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le SB-2.',
     3, 75, 750, 'fusils_pompe', 'firemode', 'arc9_k_sb2:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== BLASTERS LEGERS: DP-24 modes -> E-9 blueprint -> E-9 modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dp24_scatter', 'DP-24: Mode Scatter',
     'Debloque le mode Scatter pour le DP-24.',
     1, 50, 500, 'blasters_legers', 'firemode', 'arc9_k_dp24:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp24_le', 'DP-24: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DP-24.',
     1, 50, 500, 'blasters_legers', 'firemode', 'arc9_k_dp24:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp24_charged', 'DP-24: Mode Charged',
     'Debloque le mode Charged pour le DP-24.',
     1, 50, 500, 'blasters_legers', 'firemode', 'arc9_k_dp24:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dp24_at', 'DP-24: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DP-24.',
     1, 50, 500, 'blasters_legers', 'firemode', 'arc9_k_dp24:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_e9_blueprint', 'Plans E-9',
     'Debloque le blaster E-9. Plus puissant que le DP-24.',
     2, 150, 4000, 'blasters_legers', 'blueprint', 'arc9_k_e9',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_e9_scatter', 'E-9: Mode Scatter',
     'Debloque le mode Scatter pour le E-9.',
     3, 75, 750, 'blasters_legers', 'firemode', 'arc9_k_e9:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_e9_le', 'E-9: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le E-9.',
     3, 75, 750, 'blasters_legers', 'firemode', 'arc9_k_e9:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_e9_charged', 'E-9: Mode Charged',
     'Debloque le mode Charged pour le E-9.',
     3, 75, 750, 'blasters_legers', 'firemode', 'arc9_k_e9:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_e9_at', 'E-9: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le E-9.',
     3, 75, 750, 'blasters_legers', 'firemode', 'arc9_k_e9:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== SMGs: CR-2 modes -> CR-2C blueprint -> CR-2C modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_cr2_scatter', 'CR-2: Mode Scatter',
     'Debloque le mode Scatter pour le CR-2.',
     1, 50, 500, 'smgs', 'firemode', 'arc9_galactic_cr2:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_cr2_le', 'CR-2: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le CR-2.',
     1, 50, 500, 'smgs', 'firemode', 'arc9_galactic_cr2:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_cr2_charged', 'CR-2: Mode Charged',
     'Debloque le mode Charged pour le CR-2.',
     1, 50, 500, 'smgs', 'firemode', 'arc9_galactic_cr2:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_cr2_at', 'CR-2: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le CR-2.',
     1, 50, 500, 'smgs', 'firemode', 'arc9_galactic_cr2:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_cr2c_blueprint', 'Plans CR-2C',
     'Debloque le SMG CR-2C. Degats superieurs au CR-2.',
     2, 150, 4000, 'smgs', 'blueprint', 'arc9_galactic_cr2c',
     '{"durasteel":15,"tibanna":10,"circuits":8}', NULL, '{}'),
    ('tech_cr2c_scatter', 'CR-2C: Mode Scatter',
     'Debloque le mode Scatter pour le CR-2C.',
     3, 75, 750, 'smgs', 'firemode', 'arc9_galactic_cr2c:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_cr2c_le', 'CR-2C: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le CR-2C.',
     3, 75, 750, 'smgs', 'firemode', 'arc9_galactic_cr2c:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_cr2c_charged', 'CR-2C: Mode Charged',
     'Debloque le mode Charged pour le CR-2C.',
     3, 75, 750, 'smgs', 'firemode', 'arc9_galactic_cr2c:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_cr2c_at', 'CR-2C: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le CR-2C.',
     3, 75, 750, 'smgs', 'firemode', 'arc9_galactic_cr2c:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== ARMES LOURDES: Z-6 modes -> Z-6 Adv blueprint -> Z-6 Adv modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_z6_scatter', 'Z-6: Mode Scatter',
     'Debloque le mode Scatter pour le Z-6.',
     1, 50, 500, 'armes_lourdes', 'firemode', 'arc9_k_z6:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_z6_le', 'Z-6: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le Z-6.',
     1, 50, 500, 'armes_lourdes', 'firemode', 'arc9_k_z6:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_z6_charged', 'Z-6: Mode Charged',
     'Debloque le mode Charged pour le Z-6.',
     1, 50, 500, 'armes_lourdes', 'firemode', 'arc9_k_z6:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_z6_at', 'Z-6: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le Z-6.',
     1, 50, 500, 'armes_lourdes', 'firemode', 'arc9_k_z6:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_z6adv_blueprint', 'Plans Z-6 Advanced',
     'Debloque le Z-6 Advanced. Cadence et degats superieurs.',
     2, 250, 10000, 'armes_lourdes', 'blueprint', 'arc9_k_z6adv',
     '{"durasteel":25,"tibanna":15,"circuits":12}', NULL, '{}'),
    ('tech_z6adv_scatter', 'Z-6 Adv: Mode Scatter',
     'Debloque le mode Scatter pour le Z-6 Advanced.',
     3, 75, 750, 'armes_lourdes', 'firemode', 'arc9_k_z6adv:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_z6adv_le', 'Z-6 Adv: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le Z-6 Advanced.',
     3, 75, 750, 'armes_lourdes', 'firemode', 'arc9_k_z6adv:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_z6adv_charged', 'Z-6 Adv: Mode Charged',
     'Debloque le mode Charged pour le Z-6 Advanced.',
     3, 75, 750, 'armes_lourdes', 'firemode', 'arc9_k_z6adv:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_z6adv_at', 'Z-6 Adv: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le Z-6 Advanced.',
     3, 75, 750, 'armes_lourdes', 'firemode', 'arc9_k_z6adv:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== LANCEURS: RPS-6 modes -> PLX-1 blueprint -> PLX-1 mode =====================
-- NOTE: Les lanceurs utilisent des categories d'attachements specifiques (pas swrp_firemodes).
-- RPS-6: swrp_ammotypes_rocket (3 modes: SACLOS, Toxic Gas, Cluster)
-- PLX-1: swrp_ammotypes_rocket_plx (1 mode: EMP)

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_rps6_saclos', 'RPS-6: Roquette SACLOS',
     'Debloque la roquette SACLOS pour le RPS-6. Guidage laser.',
     1, 50, 500, 'lanceurs', 'firemode', 'arc9_k_launcher_rps6_republic:arc9_ammo_rocket_saclos',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_rps6_gas', 'RPS-6: Roquette Gaz Toxique',
     'Debloque la roquette gaz toxique pour le RPS-6.',
     1, 50, 500, 'lanceurs', 'firemode', 'arc9_k_launcher_rps6_republic:arc9_ammo_rocket_gas',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_rps6_cluster', 'RPS-6: Roquette Cluster',
     'Debloque la roquette a fragmentation pour le RPS-6.',
     1, 50, 500, 'lanceurs', 'firemode', 'arc9_k_launcher_rps6_republic:arc9_ammo_rocket_cluster',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_plx1_blueprint', 'Plans PLX-1',
     'Debloque le lance-roquettes PLX-1. Systeme de guidage lock-on avance.',
     2, 300, 15000, 'lanceurs', 'blueprint', 'arc9_k_launcher_plx1_republic',
     '{"durasteel":30,"tibanna":20,"circuits":15}', NULL, '{}'),
    ('tech_plx1_emp', 'PLX-1: Roquette EMP',
     'Debloque la roquette EMP pour le PLX-1. Desactive les vehicules ennemis.',
     3, 75, 750, 'lanceurs', 'firemode', 'arc9_k_launcher_plx1_republic:arc9_ammo_rocket_plxpem',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== PISTOLETS: DC-17 modes -> DC-17sa blueprint -> DC-17sa modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dc17_scatter', 'DC-17: Mode Scatter',
     'Debloque le mode Scatter pour le DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc17_le', 'DC-17: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc17_charged', 'DC-17: Mode Charged',
     'Debloque le mode Charged pour le DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc17_at', 'DC-17: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dc17sa_blueprint', 'Plans DC-17sa',
     'Debloque le pistolet DC-17sa. Mode automatique et degats superieurs.',
     2, 100, 2000, 'pistolets', 'blueprint', 'arc9_k_dc17sa',
     '{"durasteel":10,"tibanna":5,"circuits":5}', NULL, '{}'),
    ('tech_dc17sa_scatter', 'DC-17sa: Mode Scatter',
     'Debloque le mode Scatter pour le DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc17sa_le', 'DC-17sa: Mode Long Engagements',
     'Debloque le mode Long Engagements pour le DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc17sa_charged', 'DC-17sa: Mode Charged',
     'Debloque le mode Charged pour le DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dc17sa_at', 'DC-17sa: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour le DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ===================== AKIMBO: Dual DC-17 modes -> Dual DC-17sa blueprint -> Dual DC-17sa modes =====================

INSERT INTO aether_tech_nodes
    (id, name, description, tier, research_cost, money_cost, category, node_type, target_ref, material_cost, icon, data)
VALUES
    ('tech_dualdc17_scatter', 'Akimbo DC-17: Mode Scatter',
     'Debloque le mode Scatter pour les Akimbo DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17_akimbo:arc9_ammo_scatter',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dualdc17_le', 'Akimbo DC-17: Mode Long Engagements',
     'Debloque le mode Long Engagements pour les Akimbo DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17_akimbo:arc9_ammo_le',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dualdc17_charged', 'Akimbo DC-17: Mode Charged',
     'Debloque le mode Charged pour les Akimbo DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17_akimbo:arc9_ammo_charged',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dualdc17_at', 'Akimbo DC-17: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour les Akimbo DC-17.',
     1, 50, 500, 'pistolets', 'firemode', 'arc9_k_dc17_akimbo:arc9_ammo_at',
     '{"tibanna":5,"circuits":3}', NULL, '{}'),
    ('tech_dualdc17sa_blueprint', 'Plans Akimbo DC-17sa',
     'Debloque les Akimbo DC-17sa. Mode automatique et degats superieurs.',
     2, 100, 3000, 'pistolets', 'blueprint', 'arc9_k_dc17sa_akimbo',
     '{"durasteel":10,"tibanna":5,"circuits":5}', NULL, '{}'),
    ('tech_dualdc17sa_scatter', 'Akimbo DC-17sa: Mode Scatter',
     'Debloque le mode Scatter pour les Akimbo DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa_akimbo:arc9_ammo_scatter',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dualdc17sa_le', 'Akimbo DC-17sa: Mode Long Engagements',
     'Debloque le mode Long Engagements pour les Akimbo DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa_akimbo:arc9_ammo_le',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dualdc17sa_charged', 'Akimbo DC-17sa: Mode Charged',
     'Debloque le mode Charged pour les Akimbo DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa_akimbo:arc9_ammo_charged',
     '{"tibanna":8,"circuits":5}', NULL, '{}'),
    ('tech_dualdc17sa_at', 'Akimbo DC-17sa: Mode Anti-Tank',
     'Debloque le mode Anti-Tank pour les Akimbo DC-17sa.',
     3, 75, 750, 'pistolets', 'firemode', 'arc9_k_dc17sa_akimbo:arc9_ammo_at',
     '{"tibanna":8,"circuits":5}', NULL, '{}')
ON DUPLICATE KEY UPDATE
    name = VALUES(name), description = VALUES(description),
    tier = VALUES(tier),
    research_cost = VALUES(research_cost), money_cost = VALUES(money_cost);

-- ============================================================================
-- 4. TECH EDGES (Dependances paralleles par paire)
-- ============================================================================
-- Structure par paire:
--   - Tous les mods d'une arme partent de weapons_base (paralleles)
--   - Le blueprint suivant requiert tous les mods (convergence)
--   - Les mods de la nouvelle arme partent du blueprint
--
-- Exemple: weapons_base -> [scatter, le, charged, at] -> nt242_blueprint -> [scatter, le, charged, at]

-- IMPORTANT: Supprimer les anciens edges armes avant re-insertion
-- (sinon les anciennes dependances lineaires restent en base)
DELETE FROM aether_tech_edges WHERE
    parent_id = 'tech_weapons_base'
    OR parent_id LIKE 'tech_dc15%'
    OR parent_id LIKE 'tech_nt242%'
    OR parent_id LIKE 'tech_dp2%'
    OR parent_id LIKE 'tech_sb2%'
    OR parent_id LIKE 'tech_e9%'
    OR parent_id LIKE 'tech_cr2%'
    OR parent_id LIKE 'tech_z6%'
    OR parent_id LIKE 'tech_rps6%'
    OR parent_id LIKE 'tech_plx1%'
    OR parent_id LIKE 'tech_dc17%'
    OR parent_id LIKE 'tech_dual%';

INSERT INTO aether_tech_edges (parent_id, child_id) VALUES
    -- === STRUCTURE: weapons_base -> blueprint arme base -> modes -> blueprint arme amelioree -> modes ===

    -- === SNIPERS: weapons_base -> DC-15X blueprint -> DC-15X modes -> NT-242 blueprint -> NT-242 modes ===
    -- weapons_base -> DC-15X blueprint
    ('tech_weapons_base', 'tech_dc15x_blueprint'),
    -- DC-15X blueprint -> DC-15X modes (paralleles)
    ('tech_dc15x_blueprint', 'tech_dc15x_scatter'),
    ('tech_dc15x_blueprint', 'tech_dc15x_le'),
    ('tech_dc15x_blueprint', 'tech_dc15x_charged'),
    ('tech_dc15x_blueprint', 'tech_dc15x_at'),
    -- Tous les DC-15X modes -> NT-242 blueprint (convergence)
    ('tech_dc15x_scatter', 'tech_nt242_blueprint'),
    ('tech_dc15x_le', 'tech_nt242_blueprint'),
    ('tech_dc15x_charged', 'tech_nt242_blueprint'),
    ('tech_dc15x_at', 'tech_nt242_blueprint'),
    -- NT-242 blueprint -> NT-242 modes (paralleles)
    ('tech_nt242_blueprint', 'tech_nt242_scatter'),
    ('tech_nt242_blueprint', 'tech_nt242_le'),
    ('tech_nt242_blueprint', 'tech_nt242_charged'),
    ('tech_nt242_blueprint', 'tech_nt242_at'),

    -- === CARABINES: weapons_base -> DC-15S blueprint -> DC-15S modes -> DC-15SE blueprint -> DC-15SE modes ===
    ('tech_weapons_base', 'tech_dc15s_blueprint'),
    ('tech_dc15s_blueprint', 'tech_dc15s_scatter'),
    ('tech_dc15s_blueprint', 'tech_dc15s_le'),
    ('tech_dc15s_blueprint', 'tech_dc15s_charged'),
    ('tech_dc15s_blueprint', 'tech_dc15s_at'),
    ('tech_dc15s_scatter', 'tech_dc15se_blueprint'),
    ('tech_dc15s_le', 'tech_dc15se_blueprint'),
    ('tech_dc15s_charged', 'tech_dc15se_blueprint'),
    ('tech_dc15s_at', 'tech_dc15se_blueprint'),
    ('tech_dc15se_blueprint', 'tech_dc15se_scatter'),
    ('tech_dc15se_blueprint', 'tech_dc15se_le'),
    ('tech_dc15se_blueprint', 'tech_dc15se_charged'),
    ('tech_dc15se_blueprint', 'tech_dc15se_at'),

    -- === FUSILS: weapons_base -> DC-15A blueprint -> DC-15A modes -> DC-15LE blueprint -> DC-15LE modes ===
    ('tech_weapons_base', 'tech_dc15a_blueprint'),
    ('tech_dc15a_blueprint', 'tech_dc15a_scatter'),
    ('tech_dc15a_blueprint', 'tech_dc15a_le'),
    ('tech_dc15a_blueprint', 'tech_dc15a_charged'),
    ('tech_dc15a_blueprint', 'tech_dc15a_at'),
    ('tech_dc15a_scatter', 'tech_dc15le_blueprint'),
    ('tech_dc15a_le', 'tech_dc15le_blueprint'),
    ('tech_dc15a_charged', 'tech_dc15le_blueprint'),
    ('tech_dc15a_at', 'tech_dc15le_blueprint'),
    ('tech_dc15le_blueprint', 'tech_dc15le_scatter'),
    ('tech_dc15le_blueprint', 'tech_dc15le_le'),
    ('tech_dc15le_blueprint', 'tech_dc15le_charged'),
    ('tech_dc15le_blueprint', 'tech_dc15le_at'),

    -- === FUSILS A POMPE: weapons_base -> DP-23 blueprint -> DP-23 modes -> SB-2 blueprint -> SB-2 modes ===
    ('tech_weapons_base', 'tech_dp23_blueprint'),
    ('tech_dp23_blueprint', 'tech_dp23_scatter'),
    ('tech_dp23_blueprint', 'tech_dp23_le'),
    ('tech_dp23_blueprint', 'tech_dp23_charged'),
    ('tech_dp23_blueprint', 'tech_dp23_at'),
    ('tech_dp23_scatter', 'tech_sb2_blueprint'),
    ('tech_dp23_le', 'tech_sb2_blueprint'),
    ('tech_dp23_charged', 'tech_sb2_blueprint'),
    ('tech_dp23_at', 'tech_sb2_blueprint'),
    ('tech_sb2_blueprint', 'tech_sb2_scatter'),
    ('tech_sb2_blueprint', 'tech_sb2_le'),
    ('tech_sb2_blueprint', 'tech_sb2_charged'),
    ('tech_sb2_blueprint', 'tech_sb2_at'),

    -- === BLASTERS LEGERS: weapons_base -> DP-24 blueprint -> DP-24 modes -> E-9 blueprint -> E-9 modes ===
    ('tech_weapons_base', 'tech_dp24_blueprint'),
    ('tech_dp24_blueprint', 'tech_dp24_scatter'),
    ('tech_dp24_blueprint', 'tech_dp24_le'),
    ('tech_dp24_blueprint', 'tech_dp24_charged'),
    ('tech_dp24_blueprint', 'tech_dp24_at'),
    ('tech_dp24_scatter', 'tech_e9_blueprint'),
    ('tech_dp24_le', 'tech_e9_blueprint'),
    ('tech_dp24_charged', 'tech_e9_blueprint'),
    ('tech_dp24_at', 'tech_e9_blueprint'),
    ('tech_e9_blueprint', 'tech_e9_scatter'),
    ('tech_e9_blueprint', 'tech_e9_le'),
    ('tech_e9_blueprint', 'tech_e9_charged'),
    ('tech_e9_blueprint', 'tech_e9_at'),

    -- === SMGs: weapons_base -> CR-2 blueprint -> CR-2 modes -> CR-2C blueprint -> CR-2C modes ===
    ('tech_weapons_base', 'tech_cr2_blueprint'),
    ('tech_cr2_blueprint', 'tech_cr2_scatter'),
    ('tech_cr2_blueprint', 'tech_cr2_le'),
    ('tech_cr2_blueprint', 'tech_cr2_charged'),
    ('tech_cr2_blueprint', 'tech_cr2_at'),
    ('tech_cr2_scatter', 'tech_cr2c_blueprint'),
    ('tech_cr2_le', 'tech_cr2c_blueprint'),
    ('tech_cr2_charged', 'tech_cr2c_blueprint'),
    ('tech_cr2_at', 'tech_cr2c_blueprint'),
    ('tech_cr2c_blueprint', 'tech_cr2c_scatter'),
    ('tech_cr2c_blueprint', 'tech_cr2c_le'),
    ('tech_cr2c_blueprint', 'tech_cr2c_charged'),
    ('tech_cr2c_blueprint', 'tech_cr2c_at'),

    -- === ARMES LOURDES: weapons_base -> Z-6 blueprint -> Z-6 modes -> Z-6 Advanced blueprint -> Z-6 Adv modes ===
    ('tech_weapons_base', 'tech_z6_blueprint'),
    ('tech_z6_blueprint', 'tech_z6_scatter'),
    ('tech_z6_blueprint', 'tech_z6_le'),
    ('tech_z6_blueprint', 'tech_z6_charged'),
    ('tech_z6_blueprint', 'tech_z6_at'),
    ('tech_z6_scatter', 'tech_z6adv_blueprint'),
    ('tech_z6_le', 'tech_z6adv_blueprint'),
    ('tech_z6_charged', 'tech_z6adv_blueprint'),
    ('tech_z6_at', 'tech_z6adv_blueprint'),
    ('tech_z6adv_blueprint', 'tech_z6adv_scatter'),
    ('tech_z6adv_blueprint', 'tech_z6adv_le'),
    ('tech_z6adv_blueprint', 'tech_z6adv_charged'),
    ('tech_z6adv_blueprint', 'tech_z6adv_at'),

    -- === LANCEURS: weapons_base -> RPS-6 blueprint -> RPS-6 modes -> PLX-1 blueprint -> PLX-1 mode ===
    ('tech_weapons_base', 'tech_rps6_blueprint'),
    ('tech_rps6_blueprint', 'tech_rps6_saclos'),
    ('tech_rps6_blueprint', 'tech_rps6_gas'),
    ('tech_rps6_blueprint', 'tech_rps6_cluster'),
    ('tech_rps6_saclos', 'tech_plx1_blueprint'),
    ('tech_rps6_gas', 'tech_plx1_blueprint'),
    ('tech_rps6_cluster', 'tech_plx1_blueprint'),
    ('tech_plx1_blueprint', 'tech_plx1_emp'),

    -- === PISTOLETS: weapons_base -> DC-17 blueprint -> DC-17 modes -> DC-17sa blueprint -> DC-17sa modes ===
    ('tech_weapons_base', 'tech_dc17_blueprint'),
    ('tech_dc17_blueprint', 'tech_dc17_scatter'),
    ('tech_dc17_blueprint', 'tech_dc17_le'),
    ('tech_dc17_blueprint', 'tech_dc17_charged'),
    ('tech_dc17_blueprint', 'tech_dc17_at'),
    ('tech_dc17_scatter', 'tech_dc17sa_blueprint'),
    ('tech_dc17_le', 'tech_dc17sa_blueprint'),
    ('tech_dc17_charged', 'tech_dc17sa_blueprint'),
    ('tech_dc17_at', 'tech_dc17sa_blueprint'),
    ('tech_dc17sa_blueprint', 'tech_dc17sa_scatter'),
    ('tech_dc17sa_blueprint', 'tech_dc17sa_le'),
    ('tech_dc17sa_blueprint', 'tech_dc17sa_charged'),
    ('tech_dc17sa_blueprint', 'tech_dc17sa_at'),

    -- === AKIMBO: weapons_base -> Dual DC-17 blueprint -> Dual DC-17 modes -> Dual DC-17sa blueprint -> Dual DC-17sa modes ===
    ('tech_weapons_base', 'tech_dualdc17_blueprint'),
    ('tech_dualdc17_blueprint', 'tech_dualdc17_scatter'),
    ('tech_dualdc17_blueprint', 'tech_dualdc17_le'),
    ('tech_dualdc17_blueprint', 'tech_dualdc17_charged'),
    ('tech_dualdc17_blueprint', 'tech_dualdc17_at'),
    ('tech_dualdc17_scatter', 'tech_dualdc17sa_blueprint'),
    ('tech_dualdc17_le', 'tech_dualdc17sa_blueprint'),
    ('tech_dualdc17_charged', 'tech_dualdc17sa_blueprint'),
    ('tech_dualdc17_at', 'tech_dualdc17sa_blueprint'),
    ('tech_dualdc17sa_blueprint', 'tech_dualdc17sa_scatter'),
    ('tech_dualdc17sa_blueprint', 'tech_dualdc17sa_le'),
    ('tech_dualdc17sa_blueprint', 'tech_dualdc17sa_charged'),
    ('tech_dualdc17sa_blueprint', 'tech_dualdc17sa_at')
ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id);

-- ============================================================================
-- 5. PROGRESSION INITIALE (REPUBLIC - noeuds armes)
-- ============================================================================
-- tech_weapons_base est 'available' (point de depart).
-- Les premiers modes de tir de chaque paire sont 'locked' (deblocables apres weapons_base).
-- Tous les autres noeuds sont 'locked'.

INSERT INTO aether_research_progress (account_id, node_id, progress, status, started_at, completed_at)
VALUES
    -- Racine
    ('REPUBLIC', 'tech_weapons_base', 0, 'available', NULL, NULL),

    -- Blueprints armes de base (locked initialement)
    ('REPUBLIC', 'tech_dc15x_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15s_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15a_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp23_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp24_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_rps6_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17_blueprint', 0, 'locked', NULL, NULL),

    -- Snipers
    ('REPUBLIC', 'tech_dc15x_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15x_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15x_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15x_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_nt242_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_nt242_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_nt242_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_nt242_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_nt242_at', 0, 'locked', NULL, NULL),

    -- Carabines
    ('REPUBLIC', 'tech_dc15s_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15s_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15s_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15s_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15se_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15se_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15se_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15se_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15se_at', 0, 'locked', NULL, NULL),

    -- Fusils
    ('REPUBLIC', 'tech_dc15a_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15a_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15a_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15a_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15le_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15le_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15le_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15le_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc15le_at', 0, 'locked', NULL, NULL),

    -- Fusils a pompe
    ('REPUBLIC', 'tech_dp23_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp23_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp23_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp23_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_sb2_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_sb2_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_sb2_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_sb2_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_sb2_at', 0, 'locked', NULL, NULL),

    -- Blasters legers
    ('REPUBLIC', 'tech_dp24_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp24_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp24_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dp24_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_e9_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_e9_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_e9_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_e9_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_e9_at', 0, 'locked', NULL, NULL),

    -- SMGs
    ('REPUBLIC', 'tech_cr2_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2c_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2c_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2c_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2c_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_cr2c_at', 0, 'locked', NULL, NULL),

    -- Armes lourdes
    ('REPUBLIC', 'tech_z6_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6adv_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6adv_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6adv_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6adv_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_z6adv_at', 0, 'locked', NULL, NULL),

    -- Lanceurs
    ('REPUBLIC', 'tech_rps6_saclos', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_rps6_gas', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_rps6_cluster', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_plx1_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_plx1_emp', 0, 'locked', NULL, NULL),

    -- Pistolets
    ('REPUBLIC', 'tech_dc17_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17sa_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17sa_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17sa_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17sa_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dc17sa_at', 0, 'locked', NULL, NULL),

    -- Akimbo
    ('REPUBLIC', 'tech_dualdc17_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17_at', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17sa_blueprint', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17sa_scatter', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17sa_le', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17sa_charged', 0, 'locked', NULL, NULL),
    ('REPUBLIC', 'tech_dualdc17sa_at', 0, 'locked', NULL, NULL)
ON DUPLICATE KEY UPDATE
    status = CASE
        WHEN status = 'completed' THEN status
        ELSE VALUES(status)
    END;

-- ============================================================================
-- VERIFICATION
-- ============================================================================

SELECT 'Armes' AS type, COUNT(*) AS count FROM aether_definitions
WHERE item_type = 'weapon';

SELECT 'Categories armes' AS type, COUNT(*) AS count FROM aether_categories
WHERE id IN ('snipers','carabines','fusils','fusils_pompe','blasters_legers','smgs','armes_lourdes','lanceurs','pistolets');

SELECT 'Tech nodes armes' AS type, COUNT(*) AS count FROM aether_tech_nodes
WHERE category IN ('armes','snipers','carabines','fusils','fusils_pompe','blasters_legers','smgs','armes_lourdes','lanceurs','pistolets');

SELECT 'Tech edges armes' AS type, COUNT(*) AS count FROM aether_tech_edges
WHERE parent_id LIKE 'tech_%' AND (parent_id = 'tech_weapons_base' OR parent_id LIKE 'tech_dc15%' OR parent_id LIKE 'tech_nt242%'
    OR parent_id LIKE 'tech_dp2%' OR parent_id LIKE 'tech_sb2%' OR parent_id LIKE 'tech_e9%'
    OR parent_id LIKE 'tech_cr2%' OR parent_id LIKE 'tech_z6%' OR parent_id LIKE 'tech_rps6%'
    OR parent_id LIKE 'tech_plx1%' OR parent_id LIKE 'tech_dc17%' OR parent_id LIKE 'tech_dual%');

-- ============================================================================
-- FIN SEED ARMES
-- ============================================================================
