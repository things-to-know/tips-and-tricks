SHELL = /usr/bin/env bash

# Python
PYTHON_PIP_TOOLS_VERSION_SPECIFIER ?= >=7.4.1

PYTHON ?= python3

VENV_DIR ?= .venv
VENV_PYTHON_VERSION ?= 3.11
OS_PYTHON_FOR_VENV = python$(VENV_PYTHON_VERSION)
VENV_PYTHON = $(VENV_DIR)/bin/python3
VENV_PIP = $(VENV_DIR)/bin/pip
PYTHON_REQUIREMENTS_SRC_FILE = requirements.in
PYTHON_REQUIREMENTS_FILE = requirements.txt
PYTHON_REQUIREMENTS_DEV_SRC_FILE = requirements-dev.in
PYTHON_REQUIREMENTS_DEV_FILE = requirements-dev.txt

# Default target
.DEFAULT_GOAL := help
.PHONY: help
.PHONY: create-venv
.PHONY: delete-venv
.PHONY: clean-pyc

all: help

# Parse and print the target names and their descriptions in a formatted way
define PY_SCRIPT_PARSE_PRINT_TARGETS
import re, sys
for line in sys.stdin:
	if match:= re.match(r'^(?P<name>[a-zA-Z_-]+[0-9a-zA-Z_-]+):.*?## (?P<msg>.*)$$', line):
		print(f"{match['name']:<30}\t{match['msg']}")
endef
export PY_SCRIPT_PARSE_PRINT_TARGETS

help: ## Show help
	@echo -e "See README.md\n"
	@echo -e "Makefile targets:\n"
	@$(PYTHON) -c "$$PY_SCRIPT_PARSE_PRINT_TARGETS" < $(MAKEFILE_LIST)

create-venv: ## Create virtual environment
	$(OS_PYTHON_FOR_VENV) -m venv --symlinks --upgrade-deps $(VENV_DIR)
	$(VENV_PIP) install --upgrade wheel

delete-venv: ## Delete Python virtual environment
	rm -rf $(VENV_DIR)

.PHONY: install-python-pip-tools
install-python-pip-tools: ## Install Python Pip Tools
	${VENV_PIP} install --require-virtualenv 'pip-tools${PYTHON_PIP_TOOLS_VERSION_SPECIFIER}'

.PHONY: compile-python-deps
compile-python-deps: ## Compile all Python dependencies
	pip-compile --strip-extras ${PYTHON_REQUIREMENTS_SRC_FILE}
	pip-compile --strip-extras ${PYTHON_REQUIREMENTS_DEV_SRC_FILE}

.PHONY: install-python-deps
install-python-deps: ## Install Python dependencies
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_FILE}
	${VENV_PIP} check

.PHONY: install-python-deps-dev
install-python-deps-dev: ## Install Python dependencies for development
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_DEV_FILE}
	${VENV_PIP} check

clean-pyc: ## Clean up generated Python bytecode files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
