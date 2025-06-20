# Make / How-to

## Simple things

### Specify the shell Make should use

```makefile
SHELL := /usr/bin/env bash
```

Shell options can be passed as well e.g. `/usr/bin/env bash -eo`.

### Get the directory of the Makefile

```makefile
ROOT_DIR := $(shell dirname $(realpath $(firstword ${MAKEFILE_LIST})))
```

Warning: don't use `=` instead of `:=` (we don't want late-binding)

Sources:

- <https://stackoverflow.com/questions/322936/common-gnu-makefile-directory-path/2547973#2547973>
- <https://stackoverflow.com/questions/18136918/how-to-get-current-relative-directory-of-your-makefile/23324703#23324703>

## Tricks

### Be able to optionally execute commands with sudo

Trick to be able, optionally, to execute **some** commands in targets using `sudo`, but not by
default, e.g. `make SUDO=sudo my-target`.

```makefile
SUDO ?=

my-target:
	${SUDO} apt-get update
```
