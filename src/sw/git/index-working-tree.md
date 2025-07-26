# Software / Git / Index and Working Tree

TODO

Note: for getting information not necessarily related to the index and the working tree, see:
[Get information](get-information.md).

## Commands

See also: [Reset, Restore and Revert](reset-restore-revert.md).

Main commands:

- `git-add`: "Add file contents to the index"
  <https://git-scm.com/docs/git-add>
- `git-checkout`: "Switch branches or restore working tree files"
  <https://git-scm.com/docs/git-checkout>
- `git-mv`: "Move or rename a file, a directory, or a symlink"
  <https://git-scm.com/docs/git-mv>
- `git-rm`: "Remove files from the working tree and from the index"
  <https://git-scm.com/docs/git-rm>
- `git-stash`: "Stash the changes in a dirty working directory away"
  <https://git-scm.com/docs/git-stash>

Other commands:

- `git-read-tree`: "Reads tree information into the index"
  <https://git-scm.com/docs/git-read-tree>
- `git-worktree`: "Manage multiple working trees"
  <https://git-scm.com/docs/git-worktree>

## Get information

Main commands:

- `git-status`: "Show the working tree status"
  <https://git-scm.com/docs/git-status>

Other commands:

- `git-ls-files`: "Show information about files in the index and the working tree"
  <https://git-scm.com/docs/git-ls-files>

## Configuration

### `gitignore`

- Command `gitignore`: "Specifies intentionally untracked files to ignore"
  <https://git-scm.com/docs/gitignore>

## Deep dive

When we run `git status`, Git compares the files in our working tree against the versions stored
in the staging area (index), and the most recent commit (`HEAD`), to show us what changes
have been made but not yet committed.

The _working tree_ is a single _checkout_ of one version of the project that we see and edit in
our file system. It consists of the files and directories that are pulled from the
Git repository's database for us to use or modify.

The _working tree_ can be considered our "sandbox" where we can experiment with changes, which are
isolated from the _repository history_ until we choose to stage and commit them.

## How-to

### Avoid verbose output when checking out a commit and resulting in detached HEAD state

- How? Set config variable `advice.detachedHead` to `false`.
- Why? The following output is annoying because it is a lot of text, and it is not an error.

```sh
git checkout ${commit_hash_long}
```

(some newlines removed for clarity)

```text
06:04:08.523
Note: switching to '${commit_hash_long}>'.
You are in 'detached HEAD' state. You can look around, make experimental changes and commit them, and you can discard any commits you make in this state without impacting any branches by switching back to a branch.
If you want to create a new branch to retain commits you create, you may do so (now or later) by using -c with the switch command.
Example: git switch -c <new-branch-name>
Or undo this operation with: git switch -
Turn off this advice by setting config variable advice.detachedHead to false
HEAD is now at ${commit_hash_short} ${commit_message}
```
