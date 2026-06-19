# Changelog

Toutes les modifications notables de ce projet sont documentées ici.

Le format suit [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [Non publié]

### Modifié
- Retours du premier dogfood : `init.md` pointe vers `SETUP.md`, étape d'adaptation des
  métadonnées au CDC, réécriture de l'intro README à l'étape PO, décision explicite sur les
  placeholders, et badge Read the Docs neutralisé par défaut.
- Règle « 1 classe = 1 fichier » : dérogation documentée pour les hiérarchies d'exceptions
  (sous-package `exceptions/` par catégorie).
- `scripts/setup_github.sh` : configuration GitHub idempotente (labels, ruleset de
  protection, environnements), tolérante au plan, câblée dans le bootstrap. `SETUP.md` §4
  corrigé (pas d'approbation de PR en mode solo ; protection indisponible en privé/Free).
- Roadmap : champs Date `Début`/`Fin` du Project (gratuits), renseignés aux transitions
  (In progress → Début, Done → Fin) ; documenté dans `gates.md` et le bootstrap.

### Ajouté
- Structure initiale du template (règles multi-IA, docs Sphinx, CI, exemples).
- Workflow multi-IA : `docs/workflow/` (rôles, gates, handoff, prompts init/orchestration).
- Sécurité de base : `bandit`, `pip-audit`, Dependabot, `SECURITY.md`.
- Dossier d'intake `docs/specifications/cahier-des-charges/` et champ `:origin:`.
- Contrat d'API publique (`__all__`) avec règle de bump majeur sur rupture.
- CI réorganisée en jobs (lint, type, security, docs, test matriciel) avec concurrency.
- Pipeline de release `release.yml` : tag `v*` → PyPI public (OIDC) + Release GitHub.
- Version dérivée du tag git via `hatch-vcs` (le tag est l'unique source de version).
- Snapshots CI : Bandit en SARIF (onglet Security), job `build` de validation packaging,
  artefacts couverture HTML + JUnit + doc HTML.
- SBOM CycloneDX (via `pip-audit`) attaché aux Releases.
- Durcissement release : TestPyPI sur pré-releases (`vX.Y.Zrc1`), attestation de
  provenance (supply chain), upload SARIF tolérant (repo privé sans GHAS).
- `docs/workflow/SETUP.md` : checklist de configuration GitHub one-time (commandes `gh`).

## [0.1.0] - 2026-06-18

### Ajouté
- Squelette du projet : `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`.
- Exemples `Greeter` (classe concrète) et `Repository` (classe abstraite) + tests miroir.
