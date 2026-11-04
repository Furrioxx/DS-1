# DS-1 — Application de connexion

Application mobile Flutter avec authentification par email et mot de passe, reliée à une API Express.js et une base de données PostgreSQL.

```
DS-1/
├── api/      # API Express.js + PostgreSQL
└── mobile/   # Application Flutter
```

## Fonctionnalités réalisées

**Application mobile (Flutter)**
- Page de connexion avec validation du formulaire (email et mot de passe)
- Affichage / masquage du mot de passe
- Indicateur de chargement pendant la connexion
- Message d'erreur en cas d'identifiants invalides
- Désérialisation de la réponse JSON en objet `User`
- Stockage sécurisé du token JWT avec `flutter_secure_storage`
- Page de profil (nom, email, rôle)
- Déconnexion (suppression du token)

**API (Express.js)**
- Endpoint de connexion `POST /login`
- Mots de passe hashés avec bcrypt
- Génération d'un token JWT à la connexion
- Base de données PostgreSQL (tables `users` et `roles`)
- Script de seeding avec 3 utilisateurs de test
- Base de données locale avec Docker Compose
- Déploiement sur VPS avec un `Dockerfile`

## Identifiants de connexion

| Rôle  | Email                    | Mot de passe  |
|-------|--------------------------|---------------|
| admin | `admin@example.com`      | `admin123`    |
| user  | `john.doe@example.com`   | `password123` |
| user  | `jane.smith@example.com` | `password123` |

## Déploiement

L'API est déployée sur mon VPS à partir du `Dockerfile` présent dans `api/`. La base PostgreSQL est hébergée sur le même serveur

API en ligne : **https://flutter.furrioxx-lab.fr**

| Méthode | Route     | Description                                                    |
|---------|-----------|----------------------------------------------------------------|
| GET     | `/`       | Hello World                                                    |
| GET     | `/health` | État de l'API                                                  |
| POST    | `/login`  | Connexion (`email`, `password`) → infos du user + token JWT    |

## Lancer le projet en local

**API**

```bash
cd api
cp .env.example .env   # puis renseigner JWT_SECRET
npm install
npm run db:up          # démarre PostgreSQL avec Docker
npm run seed           # crée les rôles et les 3 utilisateurs
npm run dev            # http://localhost:3000
```

**Application mobile**

```bash
cd mobile
flutter pub get
flutter run
```
