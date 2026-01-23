-- [[ MIGRATION 002: CATEGORIES ]]
-- Ajout de la table des catégories et indexation.

-- 1. Table Categories
CREATE TABLE IF NOT EXISTS aether_categories (
    id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(128) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Foreign Key (Safe because definitions table is empty/new)
ALTER TABLE aether_definitions
ADD CONSTRAINT fk_def_category
FOREIGN KEY (category_id) REFERENCES aether_categories(id)
ON DELETE SET NULL;
