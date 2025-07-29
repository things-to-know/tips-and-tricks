# Software / Git / Remote

TODO

## Commands

- `git-clone`: "Clone a repository into a new directory"
  <https://git-scm.com/docs/git-clone>
- `git-fetch`: "Download objects and refs from another repository"
  <https://git-scm.com/docs/git-fetch>
- `git-pull`: "Fetch from and integrate with another repository or a local branch"
  <https://git-scm.com/docs/git-pull>
- `git-push`: "Update remote refs along with associated objects"
  <https://git-scm.com/docs/git-push>
- `git-remote`: "Manage set of tracked repositories"
  <https://git-scm.com/docs/git-remote>
- `gitremote-helpers`: "Helper programs to interact with remote repositories"
  <https://git-scm.com/docs/gitremote-helpers>

## Get information

Main commands:

- `git remote`:

  - `git remote get-url {remote_name}`: Retrieves the URLs (push and fetch) for a given remote

    ```bash
    git remote get-url origin
    ```

    ```text
    git@github.com:things-to-know/tips-and-tricks.git
    ```

  - `git remote show`: Shows the list of remotes

    ```text
    origin
    ```

  - `git remote show {remote_name}`: Gives some information about the given remote

    ```bash
    git remote show origin
    ```

    `2025-07-28T03-44-01Z`

    ```text
    * remote origin
      Fetch URL: git@github.com:things-to-know/tips-and-tricks.git
      Push  URL: git@github.com:things-to-know/tips-and-tricks.git
      HEAD branch: main
      Remote branches:
        main                                        tracked
        wip/idea/inspectionProfiles-Project_Default tracked
      Local branches configured for 'git pull':
        main                                        merges with remote main
        wip/idea/inspectionProfiles-Project_Default merges with remote wip/idea/inspectionProfiles-Project_Default
      Local refs configured for 'git push':
        main                                        pushes to main                                        (up to date)
        wip/idea/inspectionProfiles-Project_Default pushes to wip/idea/inspectionProfiles-Project_Default (up to date)
    ```

Other commands:

- `git ls-remote`: "List references in a remote repository"
  <https://git-scm.com/docs/git-ls-remote>

  ```bash
  git ls-remote
  ```

  ```text
  From git@github.com:things-to-know/tips-and-tricks.git
  90e1013ac13e4871f7bdc73cd7c5a3f0d2c3297f        HEAD
  90e1013ac13e4871f7bdc73cd7c5a3f0d2c3297f        refs/heads/main
  c1760d5da881bcf9d795d2dee3311b3c5753eef0        refs/heads/wip/idea/inspectionProfiles-Project_Default
  27e6b42e390217fd701a3378abd31c0ec2691b5b        refs/pull/1/head
  ...
  8928260adcc221640c9151deb3206e6a60c9fd4e        refs/pull/9/head
  ```

## How-to

### Push a local branch to a remote branch of the same name

Push the local `main` branch to the `origin` remote's `main` branch:

```bash
git push origin main:main
```

### Push a local branch to a remote branch of a different name

Push the local `feature` branch to the `origin` remote's `qa-test` branch:

```bash
git push origin feature:qa-test
```

### Delete a remote branch

A special case achieved by specifying an empty `<src>` i.e. "pushing nothing".
For example, to delete the `feature` branch on the `origin` remote:

```bash
git push origin :feature
```

## Reference

TODO

### Command

TODO

### Configuration

TODO

- `push.default`:
  - Controls the default behavior of `git push` when no refspec is specified.
  - Possible values are: `current`, `upstream`, `simple`, `matching` (avoid), `nothing`
    - `simple`: (default) push the current branch with the same name on the remote
  - Official definition
    \[[source](<https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushdefault>)\]:
    > Defines the action `git push` should take if no refspec is given (whether from the command-line,
      config, or elsewhere). Different values are well-suited for specific workflows; for instance,
      in a purely central workflow (i.e. the fetch source is equal to the push destination),
      `upstream` is probably what you want.
- `push.autoSetupRemote`: TODO.
  See <https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushautoSetupRemote>

### Refspec

See [glossary](glossary.md#refspec).

When you run `git push`, for example, _refspec_ is the mechanism that specifies:

1.  Which remote repository to connect to (e.g., `origin`)
2.  Which local refs you want to use as the **source**
3.  Which remote refs you want to update as the **destination**

Run `git remote show origin` in a repository to see the refspecs that are currently in use.

The full syntax for a refspec is `[+]<src>:<dst>`, where:

- `[+]` (Optional): Use it to force the update, by enabling a possible _non-fast-forward update_
  (equivalent to using `--force`)
- `<src>`: source reference. For:
  - Push: the local ref that you want to push (**warning**: if empty, it will delete the remote ref)
  - Fetch: the remote ref that you want to fetch
- `<dst>`: destination reference. For:
  - Push: the ref on the remote you want to create or update
  - Fetch: the local ref where you want to store the fetched object information
    (typically a remote-tracking branch)

Regarding the updates and the optional leading `+`:

- _fast-forward update_: (default behavior for `git push` and `git fetch`)
  occurs when the destination branch can be updated by simply adding new commits on top of its
  current history
- _non-fast-forward update_: occurs when the destination branch's history has diverged from the
  source branch. This can happen if the destination branch has commits that aren't in the
  source branch, or if the source branch has been rebased or reset.

Implicit Refspecs: when you run a simple command like `git push origin main`, Git uses its
configuration to expand this into a full refspec.
In this case, it would replace `main` with `main:main`.
This behavior is controlled by settings like `push.default`.

#### For `git fetch` (Remote -\> Local)

The most common refspec for fetching is configured automatically when you clone or add a remote. You can see it in your `.git/config` file:

```ini
[remote "origin"]
url = ...
fetch = +refs/heads/*:refs/remotes/origin/*
```

Let's break down this default refspec: `+refs/heads/*:refs/remotes/origin/*`

  * `+`: Allow non-fast-forward updates. This is essential for remote-tracking branches, as a remote branch can be reset or rebased.
  * `refs/heads/*`: The `<src>`. The wildcard `*` matches all branch names under `refs/heads/` on the remote (i.e., all remote branches).
  * `:`: The separator.
  * `refs/remotes/origin/*`: The `<dst>`. The corresponding `*` means that a remote branch named `main` (`refs/heads/main`) will be mapped to a local remote-tracking branch named `origin/main` (`refs/remotes/origin/main`).

This single line tells `git fetch origin` to update all your local remote-tracking branches to match their counterparts on the remote repository.

-----

### Appendix

  *
  * **Object Names**: For a `push`, the `<src>` can be any object that resolves to a commit (like a raw SHA-1 hash), not just a branch or tag name. For example, `git push origin <sha1>:main` would push that specific commit to the `main` branch on the remote.


## Troubleshooting

TODO
