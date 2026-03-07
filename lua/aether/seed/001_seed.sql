-- [[ 1. CRÉATION DES CATÉGORIES ]]
INSERT IGNORE INTO aether_categories (id, name) VALUES
('weapons', 'Armement'),
('attachments', 'Accessoires'),
('entities', 'Divers'),
('cosmetics', 'Équipement'),

-- [[ 3. IMPORTATION DES COSMÉTIQUES ]]
REPLACE INTO aether_definitions (class_id, name, category_id, type, weight, width, height, description, model, data) VALUES
('ent_casque', 'Casque', 'cosmetics', 'item', 3.0, 2, 2, 'Casque clone.', 'models/error.mdl', '{"slot":1, "bodygroups":{"Casque":{"equipped":0, "unequipped":1}}}'),
('ent_binoculars', 'Binoculars', 'cosmetics', 'item', 0.75, 2, 1, 'Binoculars.', 'models/error.mdl', '{"slot":2, "bodygroups":{"Binoculars":{"equipped":1, "unequipped":0}}}'),
('ent_sunvisor', 'Visière', 'cosmetics', 'item', 0.3, 2, 1, 'Visière.', 'models/error.mdl', '{"slot":2, "bodygroups":{"Visiere":{"equipped":1, "unequipped":0}}}'),
('ent_rangefinder', 'Rangefinder', 'cosmetics', 'item', 0.15, 1, 1, 'Antenne visée.', 'models/error.mdl', '{"slot":3, "bodygroups":{"Rangefinder":{"equipped":1, "unequipped":0}}}'),
('ent_lampe', 'Lampe', 'cosmetics', 'item', 0.25, 1, 1, 'Lampe.', 'models/error.mdl', '{"slot":4, "bodygroups":{"Lumiere":{"equipped":1, "unequipped":0}}}'),
('ent_antena', 'Antenne', 'cosmetics', 'item', 0.1, 1, 1, 'Antenne Comms.', 'models/error.mdl', '{"slot":11, "bodygroups":{"Antenne Casque":{"equipped":1, "unequipped":0}}}'),
('ent_arm_antenna', 'Antenne Epaule', 'cosmetics', 'item', 0.35, 1, 1, 'Antenne Épaule.', 'models/error.mdl', '{}'),
('ent_pauldron_officer', 'Epaulette Officier', 'cosmetics', 'item', 0.9, 2, 1, 'Épaulette Off.', 'models/error.mdl', '{"slot":5, "bodygroups":{"Epaulette":{"equipped":2, "unequipped":0}}}'),
('ent_pauldron', 'Epaulette', 'cosmetics', 'item', 0.85, 2, 1, 'Épaulette.', 'models/error.mdl', '{"slot":5, "bodygroups":{"Epaulette":{"equipped":1, "unequipped":0}}}'),
('ent_backpack', 'Sac à dos', 'cosmetics', 'item', 4.0, 2, 3, 'Sac à dos.', 'models/error.mdl', '{"slot":6, "bodygroups":{"Sac à Dos":{"equipped":1, "unequipped":0}}}'),
('ent_armor', 'Armure', 'cosmetics', 'item', 3.0, 2, 2, 'Plastron.', 'models/error.mdl', '{}'),
('ent_aromr_arc', 'Armure ARC', 'cosmetics', 'item', 3.5, 2, 2, 'Plastron ARC.', 'models/error.mdl', '{}'),
('ent_kama', 'Kama', 'cosmetics', 'item', 2.5, 2, 3, 'Kama.', 'models/error.mdl', '{"slot":10, "bodygroups":{"Kama":{"equipped":1, "unequipped":0}}}');