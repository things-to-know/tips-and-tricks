# Software / Git / Get information

TODO

Notes:

- For getting information regarding the index and the working tree, see
  [Index and Working tree](index-working-tree.md).
- For getting information regarding branches, see
  [Branch](branch.md).

## Main commands

- `git-blame`: "Show what revision and author last modified each line of a file"
  <https://git-scm.com/docs/git-blame>
  - See also:
    - [Glossary: Blame](glossary.md#blame)
    - https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search
    - https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Debugging
- `git-log`: "Show commit logs"
  <https://git-scm.com/docs/git-log>
- `git-rev-parse`: "Pick out and massage parameters"
  <https://git-scm.com/docs/git-rev-parse>
- `git-shortlog`: "Summarize git log output"
  <https://git-scm.com/docs/git-shortlog>

## Other commands

- `git-describe`: "Give an object a human-readable name based on an available ref"
  <https://git-scm.com/docs/git-describe>
- `git-rev-list`: "Lists commit objects in reverse chronological order"
  <https://git-scm.com/docs/git-rev-list>
- `git-show`: "Show various types of objects"
  <https://git-scm.com/docs/git-show>
- `git-show-ref`: "List references in a local repository"
  <https://git-scm.com/docs/git-show-ref>
- `git-var`: "Show a Git logical variable"
  <https://git-scm.com/docs/git-var>

## How-to

### Get the commit message of a specific commit

```sh
git log -1 $commit_hash
```

- To exclude the commit metadata (author, date, etc.) and only get the commit message:
  Add the `--format=%B` option.
- To avoid pagination, add the `--no-pager` option.

Example:

```zsh
git --no-pager log -1 --format=%B 43b247c54e134e0a1854ccbc85a2dc4c4257ca68
```

`2025-06-13T11-00-28Z`

```text
Initial commit
```
