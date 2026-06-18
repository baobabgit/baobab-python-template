# AGENTS.md — Règles de développement (source unique de vérité)

> Ce fichier est **la** source des règles pour **toutes** les IA de développement
> (Codex le lit nativement ; `CLAUDE.md` l'importe ; `.cursor/rules/000-core.mdc` le reflète).
> Toute modification de règle se fait **ici**, jamais en double.

## Langage & conception

- Langage : **Python ≥ 3.11**, **orienté objet**. Respect de **SOLID**, composition > héritage.
- **1 classe = 1 fichier.** Le module porte le nom de la classe en `snake_case`
  (`class FactureClient` → `facture_client.py`).
  - *Dérogation* : une **hiérarchie d'exceptions** (classes courtes) peut être regroupée
    dans un sous-package `exceptions/` organisé **par catégorie** (un fichier par famille).
- Pas de logique exécutable au niveau module ; tout passe par des classes/méthodes.

## Librairie consommable (contrat d'API)

- Le livrable est une **librairie réutilisable**, susceptible d'être intégrée dans un
  projet parent. Ce qui est exporté dans `__all__` est un **contrat**.
- Rupture du contrat (suppression/modification incompatible d'un symbole public) →
  **bump SemVer majeur** + entrée `CHANGELOG` « BREAKING » + note de migration.
- Aucune hypothèse sur l'hôte : pas d'état global, config **injectée** (`pydantic-settings`).
  Ce dépôt *expose*, il ne *dépend jamais* d'un projet parent.

## PEP 8 & PEP 20

- Respect de **PEP 8** (style) et de **PEP 20** (Zen of Python : explicite, simple, lisible).
- **En cas de conflit entre PEP 8 et PEP 20, la PEP 8 prime.**

## Typage & style

- **Type hints obligatoires** sur toutes les signatures (paramètres et retours).
- Lint + format : **`ruff`** (unique outil). Vérification de types : **`mypy`** (mode strict).
- **Docstrings en reStructuredText (RST)** sur tout élément public
  (champs `:param:`, `:returns:`, `:raises:`, et `:spec: <ID>` pour la traçabilité).

## Tests

- Framework : **`pytest`**, structure **AAA** (Arrange / Act / Assert), tests déterministes.
- **Arborescence miroir** : `src/<pkg>/a/b/c.py` ⇒ `tests/<pkg>/a/b/test_c.py`.
- **Une classe testée = une classe de test** (`class FactureClient` ⇒ `class TestFactureClient`).
- **Classe abstraite** : on la teste via une **classe concrète de test** définie dans le fichier de test.
- Nom de test porteur de l'ID spec : `def test_FEAT_001_1_cas_nominal(...)`.
- **Couverture ≥ 90 %**, imposée par `--cov-fail-under=90` (voir `pyproject.toml`).

## Documentation

- **Sphinx** + **RST**. La doc API est générée par **`autodoc`** depuis les docstrings.
- Dossier **`docs/guides/` obligatoire**, organisé selon **Diátaxis** :
  `tutorials/` (apprendre) et `how-to/` (résoudre un problème précis).
- **`README.md`** : suit la structure « 15 sections » (voir le fichier) et porte **tous les badges**
  que le projet peut légitimement afficher (version, couverture, CI, licence, style, types, docs…).

## Arborescence (layout `src/`)

```
.
├── src/<package>/        # code (1 classe par fichier)
├── tests/<package>/      # tests en miroir de src/
├── docs/
│   ├── specifications/   # cahier des charges : US / FEAT (RST, stable)
│   ├── api/              # doc API (autodoc)
│   └── guides/           # tutorials/ + how-to/  (OBLIGATOIRE)
├── pyproject.toml        # config unique (projet, ruff, mypy, pytest, coverage)
├── .pre-commit-config.yaml
└── .github/              # CI + templates d'issues (US/FEAT/Task) + PR
```

## Environnement & dépendances

- **Toujours un environnement virtuel** : `python -m venv .venv` dans le dossier **`.venv`**.
- `.venv/` n'est **jamais** versionné (cf. `.gitignore`).
- Config projet et dépendances dans **`pyproject.toml`** (PEP 621). Install dev : `pip install -e ".[dev,docs]"`.

## Sécurité

- **Aucun secret** dans le code ou Git. Variables via `.env` (gitignoré) + `.env.example` versionné.
- Chargement/validation de la config via **`pydantic-settings`**.

## Git & traçabilité

- **Conventional Commits** portant l'ID spec : `feat(FEAT-001.1): export PDF de la facture`.
- **SemVer** pour les versions.
- Chaîne d'identifiants propagée partout :
  **US-001** → **FEAT-001.1** → **TASK-001.1.1**
  (titres d'issues, branches, commits `Closes #<n>`, noms de tests, docstrings `:spec:`).
- **Provenance** : chaque US/FEAT porte un champ `:origin:` (cahier des charges, ou projet
  externe demandeur) dans sa spec RST et son issue, pour la traçabilité inter-projets.

## Workflow

- Le processus de dev (rôles, machine à états, handoff, prompts) est décrit dans
  **`docs/workflow/`**. L'IA endosse un rôle à la fois, de façon séquentielle, et reprend
  via la **note de handoff** + le GitHub Project.
- **Format des fichiers** : les instructions opérationnelles (`AGENTS.md`, `CLAUDE.md`,
  `docs/workflow/`) sont en **Markdown** ; la **documentation du projet**
  (specifications, API, guides) est en **reStructuredText**.
- Le cahier des charges brut se dépose dans `docs/specifications/cahier-des-charges/` ;
  le rôle PO en dérive `docs/specifications/us/` (RST).

## Definition of Done (une tâche n'est close que si)

1. Code POO, 1 classe/fichier, type hints complets.
2. `ruff` (lint+format) et `mypy` strict passent.
3. Tests présents en miroir, couverture ≥ 90 %.
4. Docstrings RST + guide mis à jour si le comportement public change.
5. Commit conforme (Conventional Commits + ID), PR fusionnée.
