---
title: "Héberger une IA locale à la maison avec Ollama et Open WebUI : le guide complet"
authors: "Sebos"
date: 2026-11-22T15:50:00+01:00
draft: false
description: "Comment déployer un assistant IA privé sur son serveur domestique avec Ollama et Open WebUI pour aider aux devoirs et résumer des documents sans envoyer de données dans le cloud."
categories: ["Tech"]
tags: ["ia-locale", "ollama", "open-webui", "self-hosting", "docker", "vie-privee"]
coverImage: "cover.webp"
aliases:
  - /tech/05-ia-locale/
---

Utiliser des assistants conversationnels pour réviser une leçon d'histoire, générer des quiz de vocabulaire ou résumer un document administratif est devenu un réflexe quotidien. En revanche, envoyer les questions scolaires des enfants ou les documents de la famille sur des serveurs cloud tiers pose un vrai sujet de **confidentialité**.

La bonne nouvelle : les modèles de langage compacts (entre 7B et 14B de paramètres) tournent désormais avec une fluidité remarquable sur du matériel domestique grâce au couple **Ollama + Open WebUI**.

### L'architecture retenue pour le home-lab

L'objectif est d'offrir à toute la famille une interface web familière (proche de ChatGPT) accessible depuis n'importe quel navigateur sur le réseau local, sans abonnement ni fuite de données :

* **Ollama :** Le moteur d'inférence qui télécharge, quantifie et exécute les modèles en local (avec accélération GPU si disponible, ou CPU moderne avec 16 à 32 Go de RAM).
* **Open WebUI :** L'interface web auto-hébergée qui gère les comptes utilisateurs (un compte parent, un compte enfant), l'historique des conversations et le **RAG** (interrogation de fichiers PDF locaux).

### Déploiement avec Docker Compose

Voici la pile minimale prête à lancer sur votre serveur Linux :
```yaml
  services:
    ollama:
      image: ollama/ollama:latest
      container_name: ollama
      restart: unless-stopped
      volumes:
        - ./ollama_data:/root/.ollama
      ports:
        - "11434:11434"
  
    open-webui:
      image: ghcr.io/open-webui/open-webui:main
      container_name: open-webui
      restart: unless-stopped
      ports:
        - "3000:8080"
      environment:
        - OLLAMA_BASE_URL=http://ollama:11434
        - WEBUI_AUTH=true
      volumes:
        - ./open_webui_data:/app/backend/data
      depends_on:
        - ollama
```

Une fois les conteneurs démarrés, téléchargez un premier modèle polyvalent et performant en français :

```bash
docker exec -it ollama ollama pull mistral-small
```

### Trois usages concrets à la maison
* Coach de révision sur mesure (avec RAG) : En glissant le PDF d'un cours de SVT ou d'histoire dans Open WebUI, l'assistant génère des questions de révision basées uniquement sur le support du professeur, limitant drastiquement les hallucinations.

* Correction et reformulation d'anglais : Les enfants peuvent s'entraîner à rédiger de courts paragraphes et demander des explications grammaticales pas à pas.

* Synthèse de documents administratifs : Analyse rapide d'une notice technique ou d'un règlement intérieur directement en local, sans téléverser le fichier sur Internet.


### Ce qu'il faut retenir côté matériel
Sans carte graphique dédiée, privilégiez des modèles quantifiés en 4 bits (Q4_K_M) autour de 7 à 8 milliards de paramètres (comme Llama 3.1 8B ou Mistral 7B) : ils tiennent dans moins de 6 Go de mémoire vive et génèrent environ 15 à 25 tokens par seconde sur un processeur récent, ce qui reste tout à fait confortable pour la lecture en temps réel.
