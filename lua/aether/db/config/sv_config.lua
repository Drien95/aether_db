-- [[ AETHER CORE - SERVER CONFIGURATION ]]
-- Contains sensitive credentials. Do NOT commit strictly if customized.
-- This file is Server-Side ONLY.

Aether.Config = Aether.Config or {}

Aether.Config.Database = {
    host = "127.0.0.1",
    username = "root",
    password = "root",
    database = "v6_aether_dev",
    port = 3306
}

Aether.Config.CurrencySymbol = "$"

print("[AETHER] Server Config Loaded")
