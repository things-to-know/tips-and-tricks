# Software / Git / Commit

TODO

## Commands

- `git-commit`: "Record changes to the repository"
  <https://git-scm.com/docs/git-commit>
- `git-verify-commit`: "Check the GPG signature of commits"
  <https://git-scm.com/docs/git-verify-commit>

## How-to

### Set date of commit

See also:

- [Glossary / Commit author date](glossary.md#commit-author-date)
- [Glossary / Commit committer date](glossary.md#commit-committer-date)

Note: instead of _date_, think datetime or timestamp.

- You will usually want to have a single date value for each commit: the same value for the
   _author date_ and the _committer date_.
  The respective env vars are:
  - [`GIT_AUTHOR_DATE`](https://git-scm.com/docs/git.html#Documentation/git.txt-codeGITAUTHORDATEcode)
  - [`GIT_COMMITTER_DATE`](https://git-scm.com/docs/git.html#Documentation/git.txt-codeGITCOMMITTERDATEcode)

- Use the `--date` option to override the _author date_ used in the commit.

- (unintuitive) When rebasing or cherry-picking, you can use the
  [`--reset-author`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt-code--reset-authorcode)
  option to reset the _author date_ and _committer date_ to the current datetime (besides
  resetting the author, of course).
