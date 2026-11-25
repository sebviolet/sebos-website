---
title: "Filtrer les publicités et sécuriser le réseau familial au niveau DNS"
authors: "Sebos"
date: 2026-11-22T18:30:00+01:00
draft: false
description: "Comment bloquer les traqueurs, les publicités intrusives et les contenus inappropriés sur tous les appareils de la maison grâce au DNS."
categories: ["Tech"]
tags: ["reseau", "dns", "securite", "parentalite-numerique"]
coverImage: "cover.webp"
aliases:
  - /tech/04-filtrage-dns-reseau-familial/
---

Installer un bloqueur de publicités sur chaque ordinateur, tablette, smartphone et console de la maison devient vite ingérable. La solution la plus propre et la plus légère consiste à agir directement au niveau de la **résolution DNS**.

## Le principe du filtrage DNS

Chaque fois qu'un appareil cherche à joindre un domaine (`exemple.com`), il interroge un résolveur DNS pour obtenir son adresse IP. En utilisant un résolveur filtrant (comme **AdGuard Home**, **Pi-hole** en auto-hébergement, ou un profil **NextDNS**), les requêtes vers les régies publicitaires, les traqueurs et les domaines malveillants reçoivent une réponse vide (`0.0.0.0`) avant même qu'une connexion ne soit établie.

## Deux approches selon votre installation

### Option 1 : Auto-hébergement local (Pi-hole ou AdGuard Home)

Idéal si vous disposez déjà d'un Raspberry Pi, d'un NAS ou d'un mini-PC allumé 24h/24 :

- Déploiement rapide via Docker Compose.
- Latence quasi nulle sur le réseau local (cache DNS sur place).
- Possibilité de créer des règles différentes par groupe d'appareils (par exemple, un profil plus strict pour les appareils des enfants).

### Option 2 : DNS chiffré dans le cloud (NextDNS / Control D)

Idéal pour protéger également les téléphones en 4G/5G hors de la maison via **DNS-over-HTTPS (DoH)** ou **DNS-over-TLS (DoT)** :

- Aucun matériel à maintenir à la maison.
- Activation native dans les paramètres réseau d'Android, iOS, Windows et macOS.
- Filtrage actif même lorsque les enfants sont en déplacement.

## Bonnes pratiques pour éviter les blocages frustrants

1. **Commencer avec des listes modérées** (comme *OISD* ou *HaGeZi Normal*) afin de ne pas casser les sites scolaires (Pronote, ENT) ou les services de streaming.
2. **Surveiller les journaux les premiers jours** pour ajouter en liste blanche les rares domaines légitimes bloqués par erreur.
3. **Expliquer la démarche aux enfants** : le filtrage réseau protège la vie privée et accélère la navigation, mais ne remplace jamais le dialogue sur les usages numériques.
