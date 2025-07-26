# Software / Git / Reset, Restore and Revert

## Commands

> There are three commands with similar names: `git reset`, `git restore` and `git revert`.

These commands are used for different purposes, but there is some overlap in functionality:

- `git-restore`: "Restore working tree files"
  <https://git-scm.com/docs/git-restore>
  - It "is about restoring files in the working tree from either the index or another commit.
    This command does not update your branch. The command can also be used to restore files
    in the index from another commit."
- `git-reset`: "Reset current HEAD to the specified state"
  <https://git-scm.com/docs/git-reset>
  - It "is about updating your branch, moving the tip in order to add or remove commits from
    the branch. This operation changes the commit history."
- `git-revert`: "Revert some existing commits"
  <https://git-scm.com/docs/git-revert>
  - It "is about making a new commit that reverts the changes made by other commits."

 Both `git reset` and `git restore` can be used to restore the index.

Sources:

- [Git / git Documentation / Reset, restore and revert](https://git-scm.com/docs/git#_reset_restore_and_revert)
