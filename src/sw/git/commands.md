# Software / Git / Commands

## Our classification

### Basic commands

Commands that are essential for using Git at all.

| command        | document                                        | brief description                                                    |
|----------------|-------------------------------------------------|----------------------------------------------------------------------|
| `git-add`      | [Index and Working Tree](index-working-tree.md) | "Add file contents to the index"                                     |
| `git-branch`   | [Branch](branch.md)                             | "List, create, or delete branches"                                   |
| `git-checkout` | [Index and Working Tree](index-working-tree.md) | "Switch branches or restore working tree files"                      |
| `git-clone`    | [Remote](remote.md)                             | "Clone a repository into a new directory"                            |
| `git-commit`   | [Commit](commit.md)                             | "Record changes to the repository"                                   |
| `git-diff`     | [Diff](diff.md)                                 | "Show changes between commits, commit and working tree, etc."        |
| `git-fetch`    | [Remote](remote.md)                             | "Download objects and refs from another repository"                  |
| `git-init`     | TODO                                            | "Create an empty Git repository or reinitialize an existing one"     |
| `git-log`      | [Get information](get-information.md)           | "Show commit logs"                                                   |
| `git-merge`    | [Merge](merge.md)                               | "Join two or more development histories together"                    |
| `git-mv`       | [Index and Working Tree](index-working-tree.md) | "Move or rename a file, a directory, or a symlink"                   |
| `git-pull`     | [Remote](remote.md)                             | "Fetch from and integrate with another repository or a local branch" |
| `git-push`     | [Remote](remote.md)                             | "Download objects and refs from another repository"                  |
| `git-remote`   | [Remote](remote.md)                             | "Manage set of tracked repositories"                                 |
| `git-rm`       | [Index and Working Tree](index-working-tree.md) | "Remove files from the working tree and from the index"              |
| `git-status`   | [Index and Working Tree](index-working-tree.md) | "Show the working tree status"                                       |

### Our selection of useful commands

Besides the basic commands, these commands are useful for most users, for normal and advanced
usage of Git.

- `git-cherry-pick`: "Apply the changes introduced by some existing commits"
- `git-difftool`: "Show changes using common diff tools"
- `git-hook`: "Run git hooks"
- `git-mergetool`: "Run merge conflict resolution tools to resolve merge conflicts"
- `git-reflog`: "Manage reflog information"
- `git-reset`: "Reset current HEAD to the specified state"
- `git-restore`: "Restore working tree files"
- `git-show-branch`: "Show branches and their commits"
- `git-stash`: "Stash the changes in a dirty working directory away"
- `git-submodule`: "Initialize, update or inspect submodules"
- `git-tag`: "Create, list, delete or verify a tag object signed with GPG"
- `githooks`: "Hooks used by Git"

### Experimental commands

- `git-sparse-checkout`: "Reduce your working tree to a subset of tracked files"
  (experimental as of 2.50.1)
  <https://git-scm.com/docs/git-sparse-checkout>
- `git-switch`: "Switch branches"
  (experimental as of 2.50.1)
  <https://git-scm.com/docs/git-switch>

### Low-level commands

These commands are too low-level for most users, and it is unlikely that you will need to use them.

- `git-apply`: "Apply a patch to files and/or to the index"
- `git-check-ref-format`: "Ensures that a reference name is well formed"
- `git-checkout-index`: "Copy files from the index to the working tree"
- `git-commit-graph`: "Write and verify Git commit-graph files"
- `git-commit-tree`: "Create a new commit object"
- `git-fast-import`: "Backend for fast Git data importers"
- `git-filter-branch`: "Rewrite branches"
- `git filter-repo`: "Quickly rewrite git repository history"
  ([officially recommended](https://git-scm.com/docs/git-filter-branch)
  replacement of `filter-branch`)
  <https://github.com/newren/git-filter-repo/>
- `git-hash-object`: "Compute object ID and optionally create an object from a file"
- `git-read-tree`: "Reads tree information into the index"
- `git-remote-ext`: "Bridge smart transport to external command"
- `git-remote-fd`: "Reflect smart transport stream back to caller"
- `git-replace`: "Create, list, delete refs to replace objects"
- `git-symbolic-ref`: "Read, modify and delete symbolic refs"
- `git-update-ref`: "Update the object name stored in a ref safely"
- `git-update-index`: "Update the index using the current content found in the working tree"
  - Use `git add` instead.
- `git-write-tree`: "Create a tree object from the current index"

### Commands to ignore

Either they:

- have been deprecated
- have been replaced by other, better commands
- aren't very useful

Commands:

- `git-annotate`: "Annotate file lines with commit information"
  <https://git-scm.com/docs/git-annotate>
  - Use `git blame` instead.

Not a command:

- grafts mechanism: outdated and error-prone
