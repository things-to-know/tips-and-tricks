# Software / Git / Ref

References, revision parameters, symbolic references, etc.

## Definitions

### Reference

Aka "ref", "ref name".

Definition: see [reference (glossary)](glossary.md#reference).

The _ref namespace_ is hierarchical.
Ref names must either: a) start with `refs/`, or b) be located in the root of the hierarchy.

Different subhierarchies are used for different purposes.
For example, the `refs/heads/` hierarchy is used to represent local branches whereas the
`refs/tags/` hierarchy is used to represent local tags.

Details:

- "Refs are stored in the [repository](#repository) in the `$GIT_DIR/refs/` directory"
- "For convenience, a _ref_ can sometimes be abbreviated when used as an argument to a Git command;
  see `gitrevisions` \[(man page)\] for details"

If the ref name is located in the root of the hierarchy (i.e. not under `refs/`),
it must follow these rules:

- "The name consists of only upper-case characters or underscores"
- "The name ends with `_HEAD` or is equal to `HEAD`"

There are a couple of exceptions (full list as of 2.50.1), and they're all special internal
Git references used during certain processes, and aren't meant to be manipulated directly:

- `AUTO_MERGE`: during automatic merge operations
- `BISECT_EXPECTED_REV`: during the bisect process
- `NOTES_MERGE_PARTIAL`: during the process of merging notes
- `NOTES_MERGE_REF`: during the process of merging notes
- `MERGE_AUTOSTASH`: during merge operations

Source: <https://git-scm.com/docs/gitglossary#def_ref>

### Symbolic reference (symref)

TODO

## X

Types of revision parameters include:

- _branch names_ (e.g. `main`, `feature-branch`)
- _commit hashes_ (e.g. `a1b2c3d4`)
- _tag names_ (e.g. `v1.0`, `release-2023`)
- _commit ranges_ (e.g. `HEAD~3`, `main..feature-branch`)
- _other symbolic references_ (e.g. `HEAD`, `ORIG_HEAD`)
- Historical reference: `ref@{n}` or `ref@{<date>}`
- Commit message search pattern:
  - Syntax: `:/<text>`
  - Example: `git show :/"Initial commit"` will find the first commit in the current history that
    contains the phrase "Initial commit" in its message

There are special flags that can be used to specify revision parameters in Git commands:

- `--all`: to include all references (all refs in the `refs/` namespace)

See `man gitrevisions`.
