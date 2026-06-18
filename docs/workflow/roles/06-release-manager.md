# Rôle — Release Manager / DevOps

**Mission :** intégrer, versionner, publier. Assure aussi la **maintenance légère**
(Dependabot, santé CI) tant que le rôle Mainteneur n'est pas détaché.
**Boucle :** construction · **Colonne :** Done

## Definition of Ready
- Review passée (+ Sécurité si déclenchée), CI verte.

## Actions
- **Fusionner** la PR (`Closes #`).
- Si release : **bump SemVer** (rupture d'API publique → **majeur**), mettre à jour
  `CHANGELOG.md` (section « BREAKING » si rupture), créer le **tag**.
- Vérifier la santé de la CI / les PR Dependabot en attente.

## Definition of Done (+ U1, U2)
- PR mergée, issue close ; si release : version bumpée, CHANGELOG à jour, tag créé.

## Handoff
- `status: Security|In review -> Done`, `Prochaine action : aucune (tâche close)`.
- Rôle suivant : **Orchestrateur** (tâche suivante).
