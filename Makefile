# Notes:
# - This Makefile is designed to be used with GNU Make. It may not work properly with other
#   `make` implementations.
# - The `SHELL` variable is set to use `bash` with specific options to ensure that the commands
#   are executed in a safe manner (e.g., exiting on errors, treating unset variables as errors,
#   and preventing silent failures in pipelines).
#   Caveat: the `-u` (`nounset`) flag only catches undefined **shell** variables
# - Wherever possible, the Make variable syntax uses curly braces (`${VAR}`) instead of parentheses (`$(VAR)`)
#	to ease code portability between Makefiles and Bash scripts.
#	- We will continue using parentheses for Make functions such as: `$(abspath ...)`, `$(patsubst ...)`,
#		`$(shell ...)`, `$(subst ...)`, `$(wildcard ...)` and for Make variables that would mean something different
#		in Bash or would not work there at all, such as: `$(*:.in=.txt)`, `$(*)`, etc.
SHELL = /usr/bin/env bash -e -u -o pipefail

# Note: helps to detect errors in the Makefile itself
# https://www.gnu.org/software/make/manual/html_node/Options-Summary.html#index-_002d_002dwarn_002dundefined_002dvariables
MAKEFLAGS += --warn-undefined-variables

# --------------------------------------------------------------------------------------------------
# Config
# --------------------------------------------------------------------------------------------------

# Trick to be able to execute **some** commands in targets using `sudo`, but not by default.
# Example: `make SUDO=sudo docker-build`
SUDO ?=

# Sources root directory
SRC_DIR = src

# Warning: do not use `=` instead of `:=` (we don't want late-binding)
# Source:
# https://github.com/things-to-know/tips-and-tricks/blob/main/src/sw/make/how-to.md#get-the-directory-of-the-makefile
ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))

# Python
PYTHON_PIP_TOOLS_VERSION_SPECIFIER ?= >=7.5.3

PYTHON ?= python3

VENV_DIR ?= .venv
VENV_PYTHON_VERSION ?= 3.13
OS_PYTHON_FOR_VENV = python${VENV_PYTHON_VERSION}
VENV_BIN = ${VENV_DIR}/bin
VENV_PYTHON = ${VENV_BIN}/python3
VENV_PIP = ${VENV_BIN}/pip
PYTHON_REQUIREMENTS_SRC_FILE = requirements.in
PYTHON_REQUIREMENTS_FILE = requirements.txt
PYTHON_REQUIREMENTS_NO_DEPS_FILE = requirements-no-deps.in
PYTHON_REQUIREMENTS_DEV_SRC_FILE = requirements-dev.in
PYTHON_REQUIREMENTS_DEV_FILE = requirements-dev.txt

# Node.js
NODEJS_VERSION_FILE ?= .node-version

# nodeenv: Node.js virtual environment (sandbox) builder
NODEENV = ${VENV_DIR}/bin/nodeenv

# Node.js (local installation)
VENV_NODEJS_BIN_DIR ?= ${VENV_DIR}/bin
VENV_NODEJS = ${VENV_NODEJS_BIN_DIR}/node

# Default target
.DEFAULT_GOAL := help

# --------------------------------------------------------------------------------------------------
# Targets / Generic
# --------------------------------------------------------------------------------------------------

all: help

# Parse and print the target names and their descriptions in a formatted way
define PY_SCRIPT_PARSE_PRINT_TARGETS
import re, sys
for line in sys.stdin:
	if match:= re.match(r'^(?P<name>[a-zA-Z_-]+[0-9a-zA-Z_-]+):.*?## (?P<msg>.*)$$', line):
		print(f"{match['name']:<30}\t{match['msg']}")
endef
export PY_SCRIPT_PARSE_PRINT_TARGETS

.PHONY: help
help: ## Show help
	@echo -e "See README.md\n"
	@echo -e "Makefile targets:\n"
	@${PYTHON} -c "$$PY_SCRIPT_PARSE_PRINT_TARGETS" < ${MAKEFILE_LIST}

.PHONY: install-deps-tools
install-deps-tools: install-python-pip-tools
install-deps-tools: ## Install tools for dependencies management

.PHONY: compile-deps
compile-deps: compile-python-deps
compile-deps: ## Compile dependencies from source files to lock files

.PHONY: install
install: install-python-deps
install: ## Install

.PHONY: install-dev
install-dev: install-python-deps
install-dev: install-python-deps-dev
install-dev: ## Install for dev

.PHONY: clean
clean: clean-pyc
clean: ## Clean all

.PHONY: lint
lint: lint-pre-commit
lint: ## Run linters

# --------------------------------------------------------------------------------------------------
# Targets / Specific
# --------------------------------------------------------------------------------------------------

.PHONY: create-venv
create-venv: ## Create virtual environment
	${OS_PYTHON_FOR_VENV} -m venv --symlinks --upgrade-deps ${VENV_DIR}
	${VENV_PIP} install --upgrade wheel

.PHONY: delete-venv
delete-venv: ## Delete virtual environment (Python and Node.js)
	rm -rf ${VENV_DIR}

.PHONY: install-node
install-node: ## Install Node.js into the Python virtual environment
	${VENV_PIP} show --quiet nodeenv
	${NODEENV} --node="$$(cat .node-version)" --with-npm --npm 'latest' --prebuilt --python-virtualenv
	@echo -e "\nNode installed in local Python virtualenv"
	@${VENV_NODEJS} --version

.PHONY: install-python-pip-tools
install-python-pip-tools: ## Install Python Pip Tools
	${VENV_PIP} install --require-virtualenv 'pip-tools${PYTHON_PIP_TOOLS_VERSION_SPECIFIER}'

.PHONY: compile-python-deps
compile-python-deps: ## Compile all Python dependencies
	@# Note: as of v7.4.1, `pip-tools` needs `--strip-extras` to prevent unnecessary warnings
	${VENV_BIN}/pip-compile \
		--strip-extras \
		--output-file ${PYTHON_REQUIREMENTS_FILE} \
		 ${PYTHON_REQUIREMENTS_SRC_FILE}
	${VENV_BIN}/pip-compile \
		--strip-extras \
		--output-file ${PYTHON_REQUIREMENTS_DEV_FILE} \
		 ${PYTHON_REQUIREMENTS_DEV_SRC_FILE}
	@# Note: as of v7.4.1, `pip-tools` uses the absolute path for the constraints in the output file
	sed -i 's|#   -c ${ROOT_DIR}/|#   -c |g' ${PYTHON_REQUIREMENTS_FILE}
	sed -i 's|#   -c ${ROOT_DIR}/|#   -c |g' ${PYTHON_REQUIREMENTS_DEV_FILE}

.PHONY: install-python-deps
install-python-deps: ## Install Python dependencies
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_FILE}
	# Note: to avoid false negative when running the checks, we must uninstall the packages
	# for which we intentionally ignore their dependencies. We can then reinstall them quickly
	# because they are already cached.
	@if grep -q '^[^#[:space:]]' ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; then \
		${VENV_PIP} uninstall --yes -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; \
	fi
	${VENV_PIP} check
	@if grep -q '^[^#[:space:]]' ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; then \
		${VENV_PIP} install --no-deps -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; \
	fi

.PHONY: install-python-deps-dev
install-python-deps-dev: ## Install Python dependencies for development
	${VENV_PIP} install -r ${PYTHON_REQUIREMENTS_DEV_FILE}
	# Note: to avoid false negative when running the checks, we must uninstall the packages
	# for which we intentionally ignore their dependencies. We can then reinstall them quickly
	# because they are already cached.
	@if grep -q '^[^#[:space:]]' ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; then \
		${VENV_PIP} uninstall --yes -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; \
	fi
	${VENV_PIP} check
	@if grep -q '^[^#[:space:]]' ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; then \
		${VENV_PIP} install --no-deps -r ${PYTHON_REQUIREMENTS_NO_DEPS_FILE}; \
	fi

.PHONY: clean-pyc
clean-pyc: ## Clean up generated Python bytecode files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

.PHONY: lint-pre-commit
lint-pre-commit: ## Run Mypy static type checker
	${VENV_BIN}/pre-commit run --all-files
