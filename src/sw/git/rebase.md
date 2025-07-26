# Software / Git / Rebase

TODO

<https://git-scm.com/docs/git-rebase>

## Explanation

### Backends

TLDR: use the `merge` backend.

`git rebase` has two
[primary backends](https://git-scm.com/docs/git-rebase#_behavioral_differences):

- `apply` backend:
  (fka `am` backend, but the name led to confusion as it looks like a verb instead of a noun)
  Lots of issues; just avoid it.
- `merge` backend: fka the "interactive backend", but it is now used for non-interactive cases
  as well.

Both were renamed based on lower-level functionality that underpinned each.
There are some subtle differences in how these two backends behave.

## Reference

TODO

### Command

TODO

Options:

- [`--stat`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---stat)

Datetime and author:

- <https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---stat>
- <https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---ignore-date>
- <https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---reset-author-date>

## How-to

TODO

### Run a command for each commit in an interactive rebase

TODO

It is based in the solution of
[Rebase interactively with a custom editor](#rebase-interactively-with-a-custom-editor).

### Rebase interactively with a custom editor

How? Several alternatives:

- Set the Git "sequence editor" to your preferred editor (if not set, it defaults to the commit
  message editor)
  - Set the `GIT_SEQUENCE_EDITOR` env var to your preferred editor,
    e.g. `export GIT_SEQUENCE_EDITOR=vim`.
  - Set the `sequence.editor` config variable e.g. `git config sequence.editor vim`.
  - Set the command option `-c sequence.editor=vim` when running the `git rebase` command.
- Set the Git editor to your preferred editor (beware that this would change the editor for
  **all Git commands** that use an editor):
  - Set the `GIT_EDITOR` env var e.g. `export GIT_EDITOR=vim`.
  - Set the `core.editor` config variable e.g. `git config core.editor vim`.
  - Set the command option `-c core.editor=vim` when running the `git rebase` command.

Documentation and sources:

- Git docs / `git rebase` /
  [`sequence.editor`](https://git-scm.com/docs/git-rebase.html#Documentation/git-rebase.txt-sequenceeditor)
- Git docs / `git config` /
  [`sequence.editor`](https://git-scm.com/docs/git-config.html#Documentation/git-config.txt-sequenceeditor)
- Git docs / `git` / env vars /
  [`GIT_SEQUENCE_EDITOR`](https://git-scm.com/docs/git.html#Documentation/git.txt-codeGITSEQUENCEEDITORcode)
- Git docs / `git` / env vars /
  [`GIT_EDITOR`](https://git-scm.com/docs/git.html#Documentation/git.txt-codeGITEDITORcode)
