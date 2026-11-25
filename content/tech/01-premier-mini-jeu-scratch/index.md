---
title: "Créer ton premier mini-jeu d'arcade avec Scratch en 20 minutes"
authors: "Sebos"
date: 2026-11-20T14:00:00+01:00
draft: false
description: "Un défi pas à pas pour coder ton propre jeu d'esquive de météorites dans ton navigateur."
categories: ["Tech"]
series: ["Découverte du Code"]
tags: ["code", "scratch", "jeu-video"]
coverImage: "cover.webp"
aliases:
  - /tech/01-premier-mini-jeu-scratch/
---

Tu joues souvent à des jeux vidéo, mais sais-tu que tu peux fabriquer le tien en moins de 20 minutes directement dans ton navigateur ? Aujourd'hui, on crée un jeu spatial où ton vaisseau doit esquiver des météorites pour gagner des points !

## Ce qu'il te faut

- Un ordinateur avec une connexion Internet.
- Le site gratuit **Scratch** (`scratch.mit.edu`), sans même avoir besoin de créer un compte pour commencer.

## Étape 1 : Choisis ton vaisseau et le décor

1. Supprime le chat Scratch par défaut en cliquant sur la petite poubelle de son icône.
2. Clique sur **Choisir un arrière-plan** (en bas à droite) et sélectionne *Stars* ou *Nebula*.
3. Clique sur **Choisir un sprite** et prends *Rocketship* (la fusée). Réduis sa taille à `50` pour qu'elle puisse slalomer facilement.

## Étape 2 : Piloter la fusée au clavier

Ajoute ces blocs dans l'onglet **Code** de ta fusée pour la déplacer à gauche et à droite :

- **Quand le drapeau vert est cliqué** :
  - Aller à `x: 0`, `y: -130`
  - **Répéter indéfiniment** :
    - Si `touche flèche droite pressée ?` alors `ajouter 8 à x`
    - Si `touche flèche gauche pressée ?` alors `ajouter -8 à x`

## Étape 3 : Faire tomber les météorites

1. Ajoute un deuxième sprite : *Rocks* (un astéroïde).
2. Crée une variable appelée **Score** dans la catégorie *Variables*.
3. Programme l'astéroïde pour qu'il tombe du haut de l'écran :
   - **Quand le drapeau vert est cliqué** :
     - Mettre `Score` à `0`
     - **Répéter indéfiniment** :
       - Aller à `x: nombre aléatoire entre -200 et 200`, `y: 180`
       - **Répéter jusqu'à ce que** `ordonnée y < -170` :
         - `Ajouter -7 à y`
         - Si `touche le Rocketship ?` alors `stop tout` (Game Over !)
       - `Ajouter 1 à Score`

## Le défi bonus

Essaie d'accélérer la chute des météorites dès que ton **Score** dépasse `10`, ou ajoute un son de laser quand tu démarres la partie !
