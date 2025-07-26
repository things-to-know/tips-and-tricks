# Software / Git / Submodules

TODO

See `gitsubmodules`: "Mounting one repository inside another"
<https://git-scm.com/docs/gitsubmodules>

## Commands

- `gitmodules`: "Defining submodule properties"
  <https://git-scm.com/docs/gitmodules>
- `git-submodule`: "Initialize, update or inspect submodules"
  <https://git-scm.com/docs/git-submodule>

## Note about submodules and cloning or pulling

> When cloning or pulling a repository containing submodules the submodules will not be
  checked out by default; you can instruct `clone` to recurse into submodules.
>
> The `init` and `update` subcommands of `git submodule` will maintain submodules checked out
  and at an appropriate revision in your working tree.
>
> Alternatively, you can set `submodule.recurse` to have `checkout` recurse into submodules (note
  that `submodule.recurse` also affects other Git commands, see `git-config` for a complete list).

Source: <https://git-scm.com/docs/gitsubmodules>
