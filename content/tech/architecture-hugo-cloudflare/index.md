---
title: "Sous le capot : comment nous hébergeons FrenchFamily avec Hugo et Cloudflare"
author: "Seb"
date: 2026-11-21T10:00:00+01:00
draft: false
description: "Retour d'expérience sur l'architecture statique du blog : Hugo sans thème externe, Page Bundles et déploiement sur Cloudflare Workers."
categories: ["Tech"]
tags: ["hugo", "cloudflare", "architecture", "webdev"]
coverImage: "cover.webp"
---

Pour créer un blog familial durable, rapide et sans maintenance lourde, le choix d'un générateur de site statique s'est vite imposé face à un CMS traditionnel (base de données à sauvegarder, mises à jour de sécurité permanentes, hébergement coûteux).

Voici l'architecture exacte derrière **frenchfamily.fr**.

## 1. Hugo sans thème externe

Plutôt que d'importer un thème complexe de plusieurs milliers de lignes, le site repose sur un jeu de templates HTML minimalistes dans `layouts/` et une feuille de style unique (`assets/css/main.css`) qui gère automatiquement les thèmes clair et sombre via `prefers-color-scheme`.

### Pourquoi ce choix ?

- **Zéro dépendance** : aucun sous-module Git ni thème tiers qui casse lors d'une montée de version de Hugo.
- **Performance maximale** : le CSS est minifié et doté d'une empreinte (`fingerprint`) au moment du build, sans aucun framework JavaScript côté client.
- **Double identité visuelle** : la page d'accueil sépare clairement l'espace *Famille & Passions* (écrit par les enfants) et le *Blog Technique*.

## 2. Organisation en Page Bundles et images WebP

Chaque article est structuré sous forme de **Hugo Page Bundle** : un dossier dédié contenant le fichier `index.md` et ses ressources locales (`cover.webp`, captures d'écran).

Un *Markdown Render Hook* (`layouts/_default/_markup/render-image.html`) intercepte chaque image et appelle le partial `responsive-image.html` pour générer automatiquement plusieurs résolutions WebP (`480w` et `800w`) avec `loading="lazy"`.

## 3. Déploiement continu sur Cloudflare Workers

Le dépôt Git est relié à Cloudflare via `wrangler.toml` et un script `build.sh` autonome :

```toml
name = 'sebos-website'
compatibility_date = '2026-08-01'

[build]
command = 'chmod a+x build.sh && ./build.sh'

[assets]
directory = './public'
not_found_handling = '404-page'
```

À chaque `git push`, Cloudflare exécute `build.sh`, compile le site avec `hugo build --gc --minify` et publie le dossier `./public` sur son réseau edge mondial en quelques secondes.
