# Contribuer

Merci de contribuer ! Les **règles de développement** font foi dans
[`AGENTS.md`](AGENTS.md) (source unique partagée par Claude Code, Cursor et Codex).
Ce document décrit le **processus**.

## Mise en place

```bash
python -m venv .venv
# activer le venv puis :
pip install -e ".[dev,docs]"
pre-commit install
```

## Cycle de contribution

1. **Prendre une tâche** dans GitHub Issues/Projects (`TASK-XXX.Y.Z`).
2. **Créer une branche** : `feat/FEAT-001.1-salutations` ou `fix/...`.
3. **Développer** en respectant `AGENTS.md` :
   - 1 classe = 1 fichier ; type hints complets ; docstrings RST avec `:spec:`.
   - Test miroir obligatoire (`tests/.../test_*.py`) ; classe abstraite testée
     via une classe concrète de test.
4. **Vérifier** : `make check` (lint + types + tests ≥ 90 %).
5. **Committer** en [Conventional Commits](https://www.conventionalcommits.org/)
   avec l'ID et la fermeture d'issue :
   ```
   feat(FEAT-001.1): générer des salutations

   Closes #42
   ```
6. **Ouvrir une PR** : la CI doit être verte avant revue/fusion.

## Definition of Done

Voir la section *Definition of Done* dans [`AGENTS.md`](AGENTS.md).
