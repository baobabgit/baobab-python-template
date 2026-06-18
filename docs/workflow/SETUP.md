# Configuration GitHub (one-time)

Étapes de configuration non versionnables dans le repo, à faire **une fois** après
création du projet. Remplace `OWNER/REPO` par les valeurs réelles.

> Prérequis : `gh auth login` puis `gh auth refresh -s project` (scope Projects).

## 1. Marquer le dépôt comme template (sur le repo template uniquement)

```bash
gh api -X PATCH repos/OWNER/REPO -F is_template=true
```

Créer un projet à partir du template :

```bash
gh repo create OWNER/mon-projet --template OWNER/templates --private --clone
```

## 2. Labels (US / FEAT / Task + priorités)

```bash
gh label create "type:us"        -c "#0e8a16" -d "User Story"   -R OWNER/REPO
gh label create "type:feat"      -c "#1d76db" -d "Feature"      -R OWNER/REPO
gh label create "type:task"      -c "#5319e7" -d "Task"         -R OWNER/REPO
gh label create "priority:high"  -c "#d93f0b" -R OWNER/REPO
gh label create "priority:med"   -c "#fbca04" -R OWNER/REPO
gh label create "priority:low"   -c "#c2e0c6" -R OWNER/REPO
gh label create "dependencies"   -c "#0366d6" -R OWNER/REPO
```

## 3. GitHub Project (board + colonnes + sprints)

```bash
gh project create --owner OWNER --title "Mon projet"
```

Puis, dans l'UI du Project (ou via `gh project field-create`) :

- champ **Status** avec les options : `Spec`, `Design`, `In progress`, `In review`,
  `Security`, `Done` (+ `Triage` pour la maintenance) ;
- champ **Iteration** (sprints) ;
- champs `Priority`, `Estimate`.

## 4. Branch protection (applique le gate « U2 : CI verte »)

Rend les jobs CI **requis** avant tout merge sur `main` :

```bash
gh api -X PUT repos/OWNER/REPO/branches/main/protection \
  -H "Accept: application/vnd.github+json" \
  -F "required_status_checks[strict]=true" \
  -F "required_status_checks[contexts][]=lint" \
  -F "required_status_checks[contexts][]=type" \
  -F "required_status_checks[contexts][]=security" \
  -F "required_status_checks[contexts][]=test (3.11)" \
  -F "required_status_checks[contexts][]=test (3.12)" \
  -F "required_status_checks[contexts][]=test (3.13)" \
  -F "enforce_admins=true" \
  -F "required_pull_request_reviews[required_approving_review_count]=1" \
  -F "restrictions=" 
```

## 5. Environnements de publication

```bash
gh api -X PUT repos/OWNER/REPO/environments/pypi
gh api -X PUT repos/OWNER/REPO/environments/testpypi
```

(Optionnel : exiger une approbation manuelle avant publication via l'UI de l'environnement.)

## 6. Trusted Publishing (UI PyPI / TestPyPI — pas de `gh`)

Sur **pypi.org** et **test.pypi.org** → *Your projects* → *Publishing* → *Add a pending
publisher* :

- Owner : `OWNER`
- Repository : `REPO`
- Workflow : `release.yml`
- Environment : `pypi` (et `testpypi` côté TestPyPI)

Aucun token à stocker : la publication se fait par OIDC.

## 7. Sécurité (Code Scanning)

- **Repo public** : l'upload SARIF (Bandit) alimente l'onglet *Security* sans config.
- **Repo privé** : nécessite **GitHub Advanced Security**. Sans GHAS, l'étape d'upload
  SARIF est tolérée (`continue-on-error`) ; le gate Bandit/pip-audit reste actif.
- Vérifier que **Dependabot alerts** est activé (Settings → Code security).
```
