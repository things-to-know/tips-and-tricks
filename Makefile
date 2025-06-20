SHELL = /usr/bin/env bash

# Warning: do not use `=` instead of `:=` (we don't want late-binding)
# Source:
# https://github.com/things-to-know/tips-and-tricks/blob/main/src/sw/make/how-to.md#get-the-directory-of-the-makefile
ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))

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
PYTHON_REQUIREMENTS_NO_DEPS_FILE = requirements-no-deps.in
PYTHON_REQUIREMENTS_DEV_SRC_FILE = requirements-dev.in
PYTHON_REQUIREMENTS_DEV_FILE = requirements-dev.txt

# nodeenv: Node.js virtual environment (sandbox) builder
NODEENV_CONFIG_FILE ?= ${ROOT_DIR}/.nodeenvrc

NODEENV = $(VENV_DIR)/bin/nodeenv

# Node.js (local installation)
VENV_NODEJS_BIN_DIR ?= ${VENV_DIR}/bin
VENV_NODEJS = ${VENV_NODEJS_BIN_DIR}/node

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

delete-venv: ## Delete virtual environment (Python and Node.js)
	rm -rf $(VENV_DIR)

.PHONY: install-node
install-node: ## Install Node.js into the Python virtual environment
	${VENV_PIP} show --quiet nodeenv
	${NODEENV} --config-file="${NODEENV_CONFIG_FILE}" --python-virtualenv
	@echo -e "\nNode installed in local Python virtualenv"
	@${VENV_NODEJS} --version

.PHONY: install-python-pip-tools
install-python-pip-tools: ## Install Python Pip Tools
	${VENV_PIP} install --require-virtualenv 'pip-tools${PYTHON_PIP_TOOLS_VERSION_SPECIFIER}'

.PHONY: compile-python-deps
compile-python-deps: ## Compile all Python dependencies
	# Note: as of v7.4.1, `pip-tools` needs `--strip-extras` to prevent unnecessary warnings
	pip-compile \
		--strip-extras \
		--output-file ${PYTHON_REQUIREMENTS_FILE} \
		 ${PYTHON_REQUIREMENTS_SRC_FILE}
	pip-compile \
		--strip-extras \
		--output-file ${PYTHON_REQUIREMENTS_DEV_FILE} \
		 ${PYTHON_REQUIREMENTS_DEV_SRC_FILE}
	# Note: as of v7.4.1, `pip-tools` uses the absolute path for the constraints in the output file
	sed -i 's|#   -c ${ROOT_DIR}/|#   -c |g' ${PYTHON_REQUIREMENTS_FILE}
	sed -i 's|#   -c ${ROOT_DIR}/|#   -c |g' ${PYTHON_REQUIREMENTS_DEV_FILE}

.PHONY: install-python-deps
install-python-deps: ## Install Python dependencies
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_FILE}
	# Note: to avoid false negative when running the checks, we must uninstall the packages
	# for which we intentionally ignore their dependencies. We can then reinstall them quickly
	# because they are already cached.
	${VENV_PIP} uninstall --yes -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}
	${VENV_PIP} check
	${VENV_PIP} install --no-deps -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}

.PHONY: install-python-deps-dev
install-python-deps-dev: ## Install Python dependencies for development
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_DEV_FILE}
	# Note: to avoid false negative when running the checks, we must uninstall the packages
	# for which we intentionally ignore their dependencies. We can then reinstall them quickly
	# because they are already cached.
	${VENV_PIP} uninstall --yes -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}
	${VENV_PIP} check
	${VENV_PIP} install --no-deps -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}

clean-pyc: ## Clean up generated Python bytecode files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
