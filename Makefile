# Commandes standard du projet.
# Sous Windows, exécutez ces commandes via Git Bash, ou lancez-les manuellement.
.DEFAULT_GOAL := help
PY ?= python

.PHONY: help venv install lint format type test cov security docs check clean

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

venv: ## Crée l'environnement virtuel .venv
	$(PY) -m venv .venv

install: ## Installe le projet + outils de dev et docs
	$(PY) -m pip install --upgrade pip
	$(PY) -m pip install -e ".[dev,docs]"
	pre-commit install

lint: ## Lint (ruff)
	ruff check .

format: ## Formate le code (ruff)
	ruff format .

type: ## Vérification de types (mypy strict)
	mypy

test: ## Tests + couverture >= 90%
	pytest

cov: test ## Alias de test (couverture incluse)

security: ## Analyse de sécurité (bandit + pip-audit)
	bandit -c pyproject.toml -r src
	pip-audit

docs: ## Construit la documentation Sphinx (HTML)
	sphinx-build -b html docs docs/_build/html

check: lint type test ## Vérifie tout (lint + types + tests)

clean: ## Nettoie les caches et artefacts
	rm -rf .pytest_cache .mypy_cache .ruff_cache htmlcov coverage.xml .coverage docs/_build docs/api/_autosummary
