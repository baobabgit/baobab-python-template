@AGENTS.md

## Spécifique à Claude Code

Les règles de développement complètes vivent dans `@AGENTS.md` (source unique de vérité,
partagée avec Codex et Cursor). Ne les duplique pas ici.

- Avant de modifier des fichiers sous `src/`, vérifie qu'une **classe de test miroir** existe
  ou crée-la dans `tests/` (même chemin, fichier `test_<module>.py`).
- Pour une **classe abstraite**, écris une **classe concrète de test** dans le fichier de test.
- N'ajoute jamais une 2ᵉ classe dans un fichier existant : **1 classe = 1 fichier**.
- Lance `make check` (lint + types + tests ≥ 90 %) avant de proposer un commit.

<!-- Les règles dures (couverture, lint, types) sont aussi garanties par pre-commit + CI,
     indépendamment de ce que l'IA décide. -->
