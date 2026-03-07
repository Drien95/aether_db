-- Création de la table des musiques (Catalogue)
CREATE TABLE IF NOT EXISTS `aether_music_tracks` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `titre` VARCHAR(255) NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    `genre` VARCHAR(100) NOT NULL,
    `duree` VARCHAR(10) DEFAULT NULL,
    `added_by` VARCHAR(32) DEFAULT NULL COMMENT 'SteamID64',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Création de la table des playlists
CREATE TABLE IF NOT EXISTS `aether_music_playlists` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `nom_playlist` VARCHAR(150) NOT NULL,
    `createur` VARCHAR(32) NOT NULL COMMENT 'SteamID64',
    `est_publique` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Création de la table de liaison (Musiques dans les Playlists)
CREATE TABLE IF NOT EXISTS `aether_music_playlist_items` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `playlist_id` INT(11) NOT NULL,
    `track_id` INT(11) NOT NULL,
    `ordre_lecture` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `aether_music_playlists`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`track_id`) REFERENCES `aether_music_tracks`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Création de la table des logs pour les statistiques
CREATE TABLE IF NOT EXISTS `aether_music_logs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `track_id` INT(11) NOT NULL,
    `server_id` TINYINT(1) NOT NULL COMMENT '1, 2 ou 3',
    `played_by` VARCHAR(32) NOT NULL COMMENT 'SteamID64',
    `played_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`track_id`) REFERENCES `aether_music_tracks`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;