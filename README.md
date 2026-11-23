# French Family (`https://www.frenchfamily.fr/`)

Blog familial et technique propulsé par **Hugo** et déployé sur **Cloudflare Workers**.

## Structure du projet

```text
├── archetypes/             # Modèles pour nouveaux articles (family, tech)
├── assets/
│   ├── css/main.css        # Feuille de style principale (clair/sombre automatique)
│   └── img/                # Images globales du site
├── config/_default/
│   └── hugo.toml           # Configuration Hugo, taxonomies, menus & cache
├── content/
│   ├── about/              # Page À propos (Page Bundle)
│   ├── family/             # Espace Famille & Passions des enfants (Page Bundles)
│   └── tech/               # Blog Technique & Home-Lab des parents (Page Bundles)
├── layouts/                # Templates HTML sur mesure et render-hooks
└── static/                 # Fichiers statiques (favicon.png)
```

## Développement local

```bash
hugo server -D
```

## Créer un nouvel article (Page Bundle)

```bash
hugo new --kind family content/family/univers-one-piece/04-nouvel-article/index.md
hugo new --kind tech content/tech/mon-sujet-tech/index.md
```
