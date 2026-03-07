-- Migration 019: Add model columns to aether_players
-- model_path : cache du modèle actif (base choisi à la création ou skin perso équipé)
-- model_skin  : skin number sur le modèle (0 = défaut)
-- model_bg    : bodygroups JSON [{index, value}, ...] (NULL = aucun)

ALTER TABLE aether_players
ADD COLUMN model_path VARCHAR(255) NULL     DEFAULT NULL,
ADD COLUMN model_skin  INT         NOT NULL DEFAULT 0,
ADD COLUMN model_bg    TEXT        NULL     DEFAULT NULL;
