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

## 📚 Documentation SQL

Pour le détail technique des tables et relations (MCD/MLD) :
👉 [**Voir le Schéma de Données (DATABASE_SCHEMA.md)**](docs/DATABASE_SCHEMA.md)

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

### 1. Lecture (Query avec Paramètres)

Vous pouvez aussi utiliser `Prepare` pour la lecture pour éviter d'utiliser `Escape` manuellement.

```lua
-- Plus besoin de 'Aether.Database.Escape(steamID)' !
local sql = "SELECT * FROM aether_accounts WHERE id = ?"

Aether.Database.Prepare(sql, { "STEAM_0:0:12345" }, function(data)
    PrintTable(data)
end)
```

### 2. Écriture Sécurisée (Prepare) - RECOMMANDÉ

Utilisez `Prepare` pour vos INSERT et UPDATE. Cela utilise des **Placeholders (`?`)** pour empêcher les injections SQL à 100%.

```lua
-- Les '?' seront remplacés par les valeurs de la table
local sql = "UPDATE aether_accounts SET balance = ? WHERE id = ?"
local params = { 5000, "STEAM_0:0:12345" }

Aether.Database.Prepare(sql, params, function()
    print("Sauvegarde réussie !")
end)
```

### 3. Transactions (Performance)

Pour sauvegarder beaucoup de données d'un coup (ex: Save All), utilisez les transactions pour ne faire qu'une seule écriture disque.

```lua
Aether.Database.BeginTransaction()

for _, ply in ipairs(player.GetAll()) do
    local sql = "UPDATE aether_players SET money = ? WHERE steamid = ?"
    Aether.Database.Prepare(sql, { ply:GetMoney(), ply:SteamID64() })
end

Aether.Database.Commit() -- Tout appliquer d'un coup
```

### 4. File d'Attente (Write-Behind)

Pour les logs ou les actions non-critiques, `AddToQueue` permet de rendre la main immédiatement.

```lua
Aether.Database.AddToQueue("INSERT INTO logs ...")
```

---

## ⚡ Fonctionnalités Avancées

- **Keep-Alive :** Le système ping la base toutes les 5min pour éviter l'erreur "MySQL Server has gone away".
- **Circuit Breaker :** Si la DB plante, le système passe automatiquement en mode "Sécurité" pour ne pas freeze le serveur.
- **Watchdog :** Un timer surveille la file d'attente pour s'assurer qu'elle ne se bloque jamais.
