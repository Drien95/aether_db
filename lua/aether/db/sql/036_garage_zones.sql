-- [[ AETHER GARAGE - Zones de spawn ]]
-- Migration 036
-- Une zone = point de spawn nommé (pos + yaw) lié à un terminal de livraison.
-- Gérée via toolgun aether_zone_tool (2 modes : création / lien terminal).

CREATE TABLE IF NOT EXISTS aether_garage_zones (
    id         VARCHAR(64)  NOT NULL PRIMARY KEY,
    map        VARCHAR(128) NOT NULL,
    label      VARCHAR(128) NOT NULL DEFAULT 'Zone',
    pos_x      DOUBLE       NOT NULL DEFAULT 0,
    pos_y      DOUBLE       NOT NULL DEFAULT 0,
    pos_z      DOUBLE       NOT NULL DEFAULT 0,
    ang_yaw    DOUBLE       NOT NULL DEFAULT 0,
    is_active  TINYINT      NOT NULL DEFAULT 1,
    created_at BIGINT       NOT NULL DEFAULT 0
);

-- Requête principale : GetByMap (charge toutes les zones d'une map au démarrage)
CREATE INDEX IF NOT EXISTS idx_zones_map ON aether_garage_zones (map);

-- Requête secondaire : filtrage actif uniquement (GetFirstActiveZone / GetZoneForTerminal)
CREATE INDEX IF NOT EXISTS idx_zones_map_active ON aether_garage_zones (map, is_active);
