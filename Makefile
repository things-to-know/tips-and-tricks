SHELL = /usr/bin/env bash -e -o pipefail

# Notes:
# - Wherever possible, the Make variable syntax uses curly braces (`${VAR}`) instead of parentheses (`$(VAR)`)
#	to ease code portability between Makefiles and Bash scripts.
#	- We will continue using parentheses for Make functions such as: `$(abspath ...)`, `$(patsubst ...)`,
#		`$(shell ...)`, `$(subst ...)`, `$(wildcard ...)` and for Make variables that would mean something different
#		in Bash or would not work there at all, such as: `$(*:.in=.txt)`, `$(*)`, etc.

# Warning: do not use `=` instead of `:=` (we don't want late-binding)
# Source:
# https://github.com/things-to-know/tips-and-tricks/blob/main/src/sw/make/how-to.md#get-the-directory-of-the-makefile
ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))

# Trick to be able to execute **some** commands in targets using `sudo`, but not by default.
# Example: `make SUDO=sudo install-xmllint`
SUDO ?=

# Sources Root
SOURCES_ROOT = ${CURDIR}

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
VENV_NODEJS_NPM = ${VENV_NODEJS_BIN_DIR}/npm
VENV_NODEJS_MODULES_BIN_DIR ?= ./node_modules/.bin

# Other tools
JUPYTER_BOOK = $(VENV_DIR)/bin/jupyter-book
VENV_NODEJS_MARKDOWNLINT = ${VENV_NODEJS_MODULES_BIN_DIR}/markdownlint

# Usually we don't modify the PATH variable, but in this case we need to add the local node
# installation to the PATH so NPM works correctly and can find `node`. Otherwise we get the error:
# 	`/usr/bin/env: ‘node’: No such file or directory`
PATH := $(abspath ${VENV_NODEJS_BIN_DIR}):${PATH}

# Default target
.DEFAULT_GOAL := help
.PHONY: help
.PHONY: create-venv
.PHONY: delete-venv

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
	$(OS_PYTHON_FOR_VENV) -m venv --symlinks $(VENV_DIR)
	$(VENV_PIP) install --upgrade pip
	$(VENV_PIP) install --upgrade setuptools wheel

delete-venv: ## Delete virtual environment (Python and Node.js)
	rm -rf $(VENV_DIR)

lint-md-all:  ## Run `markdownlint` on all Markdown files
	@${VENV_NODEJS_MARKDOWNLINT} '**/*.md' --ignore node_modules

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

.PHONY: build-jupyter-book
build-jupyter-book: ## Build Jupyter Book
	$(JUPYTER_BOOK) build

.PHONY: build-jupyter-book-docx
build-jupyter-book-docx: ## Build Jupyter Book and export to DOCX
	$(JUPYTER_BOOK) build --docx

.PHONY: clean-pyc
clean-pyc: ## Clean up generated Python bytecode files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

.PHONY: clean-jupyter-book
clean-jupyter-book: ## Clean up files built by Jupyter Book
	$(JUPYTER_BOOK) clean

.PHONY: clean-jupyter-book-all
clean-jupyter-book-all: ## Clean up all files built, retrieved or generated in any form by Jupyter Book
	$(JUPYTER_BOOK) clean --all --yes
