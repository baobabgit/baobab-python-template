# Changelog

Toutes les modifications notables de ce projet sont documentées ici.

Le format suit [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [Non publié]

### Ajouté
- Structure initiale du template (règles multi-IA, docs Sphinx, CI, exemples).
- Workflow multi-IA : `docs/workflow/` (rôles, gates, handoff, prompts init/orchestration).
- Sécurité de base : `bandit`, `pip-audit`, Dependabot, `SECURITY.md`.
- Dossier d'intake `docs/specifications/cahier-des-charges/` et champ `:origin:`.
- Contrat d'API publique (`__all__`) avec règle de bump majeur sur rupture.

## [0.1.0] - 2026-06-18

### Ajouté
- Squelette du projet : `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`.
- Exemples `Greeter` (classe concrète) et `Repository` (classe abstraite) + tests miroir.
