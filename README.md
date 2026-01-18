# Aether DB

Le module de base de données autonome pour l'infrastructure Aether.
Il gère la connexion SQL (MySQLoo ou SQLite), la file d'attente d'écriture (Write-Behind Queue) et les migrations automatiques.

## 📁 Structure

```
aether_db/
├── addon.json              # Méta-données
└── lua/
    ├── autorun/
    │   └── aether_db_init.lua  # Point d'entrée
    └── aether/db/
        ├── config/
        │   └── sv_config.lua   # ⚠️ Configuration (Credentials)
        └── services/
            ├── sv_database.lua # Service Principal (Connexion, Query, Queue)
            ├── sv_migration.lua # Gestionnaire de Migrations
            └── migrations/     # Scripts de migration versionnés
                ├── sv_migration_v5.lua
                ├── sv_migration_v6.lua
                ├── sv_migration_v7.lua
                └── ...
```

## ⚙️ Configuration

Le fichier de configuration se trouve dans : `lua/aether/db/config/sv_config.lua`.

```lua
Aether.Config = Aether.Config or {}
Aether.Config.Database = {
    Module = "mysqloo", -- ou "sqlite"
    Host = "localhost",
    User = "root",
    Pass = "password",
    Database = "gmod_server",
    Port = 3306
}
```

> **Note :** Ce fichier contient des identifiants sensibles. Assurez-vous qu'il est ignoré par votre gestionnaire de version (ex: `.gitignore`) si vous partagez le code.

## 🔄 Système de Migration

Aether DB dispose d'un système de migration **automatique et dynamique**.
Au démarrage du serveur, le service :

1.  Scanne le dossier `migrations/`.
2.  Détecte les fichiers nommés `sv_migration_vNUMERO.lua`.
3.  Extrait le numéro de version.
4.  Trie les migrations par ordre croissant.
5.  Exécute les migrations séquentiellement.

### Comment ajouter une migration ?

Pour modifier la structure de la base de données (ajouter une table, une colonne, un index) sans casser l'existant :

1.  Créez un nouveau fichier dans `lua/aether/db/services/migrations/`.
2.  Nommez-le en incrémentant la version : `sv_migration_v8.lua` (si le dernier était v7).
3.  Utilisez le modèle suivant :

```lua
-- [[ MIGRATION V8 ]]
-- Description: Ajout de la colonne 'karma' aux joueurs

Aether.Migration = Aether.Migration or {}

Aether.Migration.V8 = function()
    print("[AETHER] Application Migration V8...")

    local query = "ALTER TABLE aether_accounts ADD COLUMN karma INTEGER DEFAULT 0;"

    Aether.Database.Query(query, function()
        print("[AETHER] V8 Succès.")
    end, function(err)
        -- Gérer les erreurs (ex: ignorer si la colonne existe déjà)
        print("[AETHER] Erreur V8: " .. err)
    end)
end
```

4.  **Redémarrez le serveur.** La migration se lancera automatiquement.

## 🚀 Utilisation (API)

Ce module expose l'objet global `Aether.Database`.
Il est conçu pour être utilisé par d'autres addons (ex: `aether_core`).

### 1. Requête Simple (Non-Bloquante)

```lua
Aether.Database.Query("SELECT * FROM users WHERE id = 'steamid'", function(data)
    PrintTable(data)
end)
```

### 2. File d'Attente (Write-Behind)

Pour les écritures fréquentes (sauvegardes, logs) où vous n'avez pas besoin d'attendre la réponse.
Cela garantit que le serveur ne lag pas ("lag-free").

```lua
-- La requête sera exécutée en arrière-plan
Aether.Database.AddToQueue("UPDATE users SET money = 100 WHERE id = 'steamid'")
```

### 3. Échappement (Sécurité)

Toujours échapper les données utilisateur pour éviter les injections SQL.

```lua
local cleanName = Aether.Database.Escape(ply:Nick())
local query = "UPDATE users SET name = " .. cleanName
```
