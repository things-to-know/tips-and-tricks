# Make / Functions

Docs:
[Functions](https://www.gnu.org/software/make/manual/html_node/Functions.html)

## Categories

### Functions for String Substitution and Analysis

Docs:
[Functions for String Substitution and Analysis](https://www.gnu.org/software/make/manual/html_node/Text-Functions.html)

- `subst`
- `patsubst`
- `firstword`
- `lastword`
- etc.

### Functions for Filenames

Docs:
[Functions for File Names](https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html)

- `abspath`: for each given path, return the absolute path
  - it doesn't resolve symlinks
  - it doesn't check if files exist
- `addprefix`
- `addsuffix`
- `basename`
- `dir`: extracts the _directory-part_ of each filename in the given list
- `join`
- `notdir`: extracts all but the _directory-part_ of each filename in the given list
- `realpath`: for each path, return the canonical absolute path
  - it resolves symlinks
  - it checks if files exist
- `suffix`
- `wildcard`: space-separated list of the names of existing files that match the given pattern.
  See [wildcard function](./path-name-expansion.md#function-wildcard).
