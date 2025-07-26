# Software / Git / Glossary

Git has a certain vocabulary used throughout the documentation, commands and options.
Many times it is not straightforward to understand the meaning of a term, because:

- it can have different meanings depending on the context
- its meaning can be different from the common meaning of the word in other similar software
- it has no official definition, or the official definition is not clear enough
- it has pseudo-official synonyms that are even used more than the official term

Unfortunately, the Git official glossary is not comprehensive, and it even has inconsistencies
(as of 2025-05-20).

## Terms

### Active submodule

A submodule is considered active is any of the following conditions are met:

- if `submodule.<name>.active` is set to true
- if the submodule's path matches the pathspec in `submodule.active`
- if `submodule.<name>.url` is set.

The conditions are evaluated in this order.

Source: <https://git-scm.com/docs/gitsubmodules>

See [Submodule](#submodule).

### Ancestor

TODO

### Bare repository

TODO: <https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-barerepository>

### Blame

One:

> Show what _revision_ and _author_ last modified each line of a file.
> _Annotates_ each line in the given file with information from the _revision_ which last modified
  the line. Optionally, start annotating from the given revision.

Two:

> The `git blame` command _annotates_ the lines of any file with which commit was the last one
  to introduce a change to each line of the file and ~~what person~~ \[which committer\] authored
  that commit.
> This is helpful in order to find the person to ask for more information about a specific
  section of your code.

Sources:

- <https://git-scm.com/docs/git-blame>
- <https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Debugging>
- <https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_file_annotation>

See [Get information](get-information.md).

### Blob object

TODO: <https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-blobobject>

### Branch

See [Branch](branch.md).

A "branch" is a line of development.

Its [branch tip](#branch-tip) moves forward as additional development (i.e. new commits)
is done on the branch.

> A single Git repository can track an arbitrary number of branches, but your
  [working tree](#working-tree) is associated with just one of them
  (the [current branch](#current-branch), and [`HEAD`](#head) points to that branch.

TODO: <https://git-scm.com/docs/gitglossary#def_branch>

### Branch head ref (head)

Warning: don't confuse a _head ref_ with [`HEAD`](#head).

It is a named reference to the [branch tip](#branch-tip) of a given branch.

Technical details: each _head_ is stored in a single file in `$GIT_DIR/refs/heads/` directory
(except when using _[packed](#pack) refs_).

Source: <https://git-scm.com/docs/gitglossary#def_head>

### Branch tip

See [Branch](#branch).

The most recent commit on a given branch is referred to as the _tip_ of that branch.
It is referenced by a single [head](#branch-head-ref-head).

Sources:

- <https://git-scm.com/docs/gitglossary#def_branch>
- Gemini 2.5 Pro

### Bisect

One:

> The `bisect` command does a binary search through your commit history to help you identify
> as quickly as possible which commit introduced an issue.

Two:

> The `git bisect` tool is an incredibly helpful debugging tool used to find which specific
  commit was the first one to introduce a bug or problem by doing an automatic binary search.

Sources:

- <https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search>
- <https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Debugging>

### Chain

TODO: <https://git-scm.com/docs/gitglossary#def_chain>

### Check out (verb)

Action executed using the command `git checkout`.

Official:

> The action of updating all or part of the [working tree](#working-tree) with a
  [tree object](#tree-object) or [blob](#blob-object) \[object\] from the
  [object database](#object-database), and updating the [index](#index) and [HEAD](#head)
  if the whole working tree has been pointed at a new [branch](#branch).

To "check out" means to switch your working directory to a specific branch, commit or tag.
This updates the files in your working directory to match the state of the selected reference.

See [Checked out (adjective)](#checked-out-adjective), and
[Index and Working tree](index-working-tree.md).

Source: <https://git-scm.com/docs/gitglossary#def_checkout>

### Checked out (adjective)

_Checked out_ is an adjective for a [branch](#current-branch), [commit](#commit-noun) or [tag](#tag-noun)
that is currently active in your
[working directory](#working-directory).
The files you see and edit in the repository are from this checked-out [reference](#reference).

Note: we would have chosen "checked-out" instead, but the Git documentation uses "checked out"
(without a hyphen).

See [Check out (verb)](#check-out-verb).

### Cherry-pick

TODO: <https://git-scm.com/docs/gitglossary#def_cherry-picking>

See [Cherry-pick](cherry-pick.md).

### Clean working tree

See also: [Dirty working tree](#dirty-working-tree).

TODO: <https://git-scm.com/docs/gitglossary#def_clean>

See [Index and Working tree](index-working-tree.md).

### Clone

TODO

See [Remote](remote.md).

### Commit (noun)

Aka "revision".

> A single point in the Git history; the entire history of a project is represented as a
  set of interrelated commits.
>
> The word "commit" is often used by Git in the same places other revision control systems
  use the words "revision" or "version".
>
> Also used as a shorthand for [commit object](#commit-object).

See [Commit](commit.md).

Sources:

- <https://git-scm.com/docs/gitglossary#def_commit>
- <https://git-scm.com/docs/gitglossary#def_revision>

See also: the documentation reference on revisions and ranges
<https://git-scm.com/docs/gitrevisions>

### Commit (verb)

> The action of storing a new snapshot of the project's state in the Git history, by creating
  a new commit representing the current state of the [index](#index) and advancing [HEAD](#head)
  to point at the new commit.

See [Commit](#commit-noun).

Source: <https://git-scm.com/docs/gitglossary#def_commit>

### Commit author date

TODO

See [Commit](commit.md).

### Commit committer date

TODO

See [Commit](commit.md).

### Commit graph

TODO:

- <https://git-scm.com/docs/gitglossary#def_commit_graph_general>
- <https://git-scm.com/docs/gitglossary#def_commit_graph_file>

### Commit object

TODO: <https://git-scm.com/docs/gitglossary#def_commit_object>

> The commit objects form a [DAG](#dag), because they have [parents](#parent) (directed),
  and the graph of commit objects is acyclic (there is no [chain](#chain) which begins and ends
  with the same object).

Source:

- <https://git-scm.com/docs/gitglossary#def_commit_object>
- <https://git-scm.com/docs/gitglossary#def_DAG>

### Commit object dereference

> The action of accessing the commit's tree object.
>
> Commits cannot be dereferenced recursively.

Source: <https://git-scm.com/docs/gitglossary#def_dereference>

### Commit-ish

TODO: <https://git-scm.com/docs/gitglossary#def_commit-ish>

### Committed

> If a particular version of a file is in the [Git directory](#git-directory),
  it is considered `committed`.

### Staged for commit (staged)

> If a particular version of a file [...] has been modified and was added to the
  ~~staging area~~ index, it is `staged`.

When a change to a file is _staged_, it is listed under the "Changes to be committed" header
when running `git status`.

### Modified

> If a particular version of a file [...] was changed since it was checked out
  but has not been _staged_, it is `modified`.

When a file that is tracked has been modified but not yet
[staged for commit](#staged-for-commit-staged), it is listed under the
"Changes not staged for commit" header when running `git status`.

Sources:

- Official Git book, section
  [Getting Started - What is Git?](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)
- Official Git book, section
  [Git Basics - Recording Changes to the Repository](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)

### Current branch

See [Branch](#branch), [`HEAD`](#head).

Aka. "Active branch", "checked out branch".

It is the branch you're currently working on, and it is the branch where the
[HEAD reference](#head) points. It is the branch that will "receive" any new commits you create
i.e. they will be added to branch's history.

How-to:

- Get the name of the _current branch_: `git branch --show-current`
- See the curren status of the repository, including the _current branch_: `git status`

Sources:

- <https://git-scm.com/docs/gitglossary#def_branch>
- Gemini 2.5 Pro

### DAG

Directed acyclic graph.

See [Commit object](#commit-object).

### Dangling object

TODO: <https://git-scm.com/docs/gitglossary#def_dangling_object>

### Dereference

Depends on what is being dereferenced:

- [Commit object dereference](#commit-object-dereference)
- [Symbolic reference dereference](#symbolic-reference-dereference)
- [Tag object dereference](#tag-object-dereference)

Note:

> Unless otherwise specified, "dereferencing" as it used in the context of Git commands or protocols
  is implicitly recursive.

Source: <https://git-scm.com/docs/gitglossary#def_dereference>

### Detached

"Detached" is a state in which there is a "detached `HEAD`".

See [Detached HEAD](#detached-head).

### Detached HEAD

When an arbitrary commit has been check out and the `HEAD` points directly to the _commit hash_.
Thus, **there is no active branch**.

The implication is that new commits **will not belong to any branch**
(until you create a new one from that point).

Explanation:

> Git also allows you to check out an arbitrary commit that isn't necessarily the _tip_
> of any particular branch.

Source: <https://git-scm.com/docs/gitglossary#def_detached_HEAD>

### Diff

TODO

See [Diff](diff.md).

### Dirty working tree

See also: [Clean working tree](#clean-working-tree).

TODO: <https://git-scm.com/docs/gitglossary#def_dirty>

See [Index and Working tree](index-working-tree.md).

### Evil merge

TODO: <https://git-scm.com/docs/gitglossary#def_evil_merge>

### Fast-forward merge

TODO: <https://git-scm.com/docs/gitglossary#def_fast_forward>

### Fetch

Official:

> Fetching a branch means to get the [branch's head ref](#branch-head-ref-head) from a
  [remote repository](#remote-repository), to find out which [objects](#object) are missing
  from the local [object database](#object-database), and to get them, too.

See [Pull](#pull) and [Remote](remote.md).

Source: <https://git-scm.com/docs/gitglossary#def_fetch>

### Git directory

Per the official Git book, section
[Getting Started - What is Git?](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F):

> \[It\] is where Git stores the metadata and object database for your project.
  [...] it is what is copied when you `clone` a repository from another computer.

It is the directory, almost always named `.git`, that contains all the essential repository
information: the object database, branch references, configuration files, hooks, and more.

By default, when you run a Git command, Git determines the location of this directory by
searching upward from your current location in the filesystem until it finds a `.git` folder.
The `$GIT_DIR` environment variable acts as a direct override to Git's default searching behavior.

### gitfile

TODO: <https://git-scm.com/docs/gitglossary#def_gitfile>

### `HEAD`

`HEAD` is a special pointer in Git that points to the [head ref](#branch-head-ref-head) of the
[current branch](#current-branch), or points directly to a _commit hash_
(when in a "[detached HEAD](#detached-head)" state).

Explanation:

> Your [working tree](#working-tree) is normally derived from the state of the _tree_ referred to
  by `HEAD`. `HEAD` is a reference to one of the [heads](#branch-head-ref-head) in your repository,
  except when using a [detached HEAD](#detached-head), in which case it directly references
  an arbitrary commit.
> Normally the [HEAD](#head) stores the name of a _branch_, and commands that operate on the
  history \[that\] `HEAD` represents operate on the history leading to the _tip_ of the branch
  the `HEAD` points at.

Source: <https://git-scm.com/docs/gitglossary#def_HEAD>

### Hook

> Hooks are programs you can place in a hooks directory to trigger actions at certain points in
  git's execution. Hooks that don't have the executable bit set are ignored.

See [Hooks](hooks.md).

Source: <https://git-scm.com/docs/gitglossary#def_hook>

### Index

Aka "staging area" or "cache" (obsolete term).

It is a file in the [Git directory](#git-directory) that stores information about what will go into
the next [commit](#commit-noun).

Technical and official definition:

> A collection of files with stat information, whose contents are stored as [objects](#object).
> \[It\] is a stored version of your [working tree](#working-tree).

Note: the _index_ can also contain more versions of a working tree (e.g. when merging),
but it is fine to ignore that.

Technical details: it is usually a single file named `index` in the `.git` directory
(`$GIT_DIR/index`). Exceptions: during a [merge conflict](#merge-conflict).

Sources:

- <https://git-scm.com/docs/gitglossary#def_index>
- Official Git book, section
  [Getting Started - What is Git?](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)
- Official Git book, section
  [Git Basics - Recording Changes to the Repository](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository)

### Index entry

Technical and official definition:

> The information regarding a particular file, stored in the [index](#index).

Note:

> \[It\] can be _unmerged_, if a [merge](#merge-verb) was started, but not yet finished
  (i.e. if the index contains multiple versions of that file).

Source: <https://git-scm.com/docs/gitglossary#def_index_entry>

### Log

TODO

See [Get information](get-information.md).

### Master

TODO: <https://git-scm.com/docs/gitglossary#def_master>

### Merge (verb)

> To bring the contents of another _branch_ (possibly from an _external repository_) into the
  [current branch](#current-branch).
>
> Merging is performed by an automatic process that identifies changes made since the
  _branches diverged_, and then applies all those changes together.
>
> In cases where [changes conflict](#merge-conflict), manual intervention may be required to
  complete the merge.

Fetch and merge:

> In the case where the _merged-in branch_ is from a different repository, this is done by
  first _fetching_ the _remote branch_ and then merging the result into the
  [current branch](#current-branch).
> This combination of [fetch](#fetch) and merge operations is called a [pull](#pull).

Source: <https://git-scm.com/docs/gitglossary#def_merge>

See [Merge](merge.md).

### Merge commit

Aka "merge" (noun).

The commit that results from a [merge](#merge-verb) operation.

Official definition:

> Unless it is a [fast-forward \[merge\]](#fast-forward-merge), a successful merge results
  in the creation of a new _commit_ representing the result of the merge, and having as
  [parents](#parent) the _tips_ of the _merged branches_.

Source: <https://git-scm.com/docs/gitglossary#def_merge>

### Merge conflict

See [Merge (verb)](#merge-verb) and [Merge commit](#merge-commit).

It is an event that occurs when Git is unable to automatically _reconcile_
_divergent changes_ between two [commits](#commit-noun).
Git will mark the conflicted files and stop the [merging process]((#merge-verb).
It is then up to the user to resolve the conflicts, or abort the merge.

This typically happens when the same lines in a file have been modified on both branches,
or when one branch modifies a file that the other deletes.

> During a merge, the working tree files are updated to reflect the result of the merge.
  [...] \[When there is conflict\], Git [...] asks you to resolve it by leaving
  what both sides did to that area.

### Merge strategy

TODO

See [Merge (verb)](#merge-verb).

### Merge tool

TODO

See [Merge (verb)](#merge-verb).

### Object

Official:

> The _unit of storage_ in Git. It is uniquely identified by the SHA-1 of its contents
  \[([object name](#object-name))\].

An object can't be changed because if it was changed, then hash value would change,
thus making it a different object.

See [Object name](#object-name).

Source: <https://git-scm.com/docs/gitglossary#def_object>

### Object database

> Stores a set of [objects](#object), and an individual _object_ is identified by its
  [object name](#object-name).
>
> The objects usually live in `$GIT_DIR/objects/`.

Source: <https://git-scm.com/docs/gitglossary#def_object_database>

### Object name

Aka "object identifier" (OID), "hash", "SHA-1" (colloquial).

> The unique identifier of an object. The object name is usually represented by a
  40-character hexadecimal string.

Source: <https://git-scm.com/docs/gitglossary#def_object_name>

See [Object](#object).

### Object type

The type of an object. It can be:

- `commit`
- `tree`
- `tag`
- `blob`

> One of the identifiers "commit", "tree", "tag" or "blob" describing the type of an object.

Source: <https://git-scm.com/docs/gitglossary#def_object_type>

See [Object](#object).

### Octopus

TODO: <https://git-scm.com/docs/gitglossary#def_octopus>

### Orphan

TODO: <https://git-scm.com/docs/gitglossary#def_orphan>

### Origin

TODO: <https://git-scm.com/docs/gitglossary#def_origin>

### Overlay

TODO: <https://git-scm.com/docs/gitglossary#def_overlay>

### Pack

TODO: <https://git-scm.com/docs/gitglossary#def_pack>

### Pack index

TODO: <https://git-scm.com/docs/gitglossary#def_pack_index>

### Parent

TODO: <https://git-scm.com/docs/gitglossary#def_parent>

### Path

TODO

### Pathspec

TODO: <https://git-scm.com/docs/gitglossary#def_pathspec>

### Peel

> The action of recursively [dereferencing a tag object](#tag-object-dereference).

Source: <https://git-scm.com/docs/gitglossary#def_peel>

### Per-worktree ref

TODO: <https://git-scm.com/docs/gitglossary#def_per-worktree_ref>

### Pickaxe

TODO: <https://git-scm.com/docs/gitglossary#def_pickaxe>

### Porcelain

TODO: <https://git-scm.com/docs/gitglossary#def_porcelain>

### Pseudoref

TODO: <https://git-scm.com/docs/gitglossary#def_pseudoref>

### Pull

The combined, sequential actions of:

1. [Fetching a branch](#fetch) from a [remote repository](#remote-repository)
   (i.e. getting the latest changes from the remote branch)
2. [Merging](#merge-verb) it into the [current branch](#current-branch).

See [Remote](remote.md).

Source: <https://git-scm.com/docs/gitglossary#def_pull>

### Push

Official:

> Pushing a branch means to get the [branch's head ref](#branch-head-ref-head)
  from a [remote repository](#remote-repository), find out if it is an [ancestor](#ancestor)
  to the branch's local head ref, and in that case, putting all objects, which are
  [reachable](#reachable) from the local head ref, and which are missing from the remote repository,
  into the remote object database, and updating the remote head ref.
  If the remote head is not an ancestor to the local head, the push fails.

TODO: <https://git-scm.com/docs/gitglossary#def_push>

See [Remote](remote.md).

### Reachability bitmaps

TODO: <https://git-scm.com/docs/gitglossary#def_reachability_bitmaps>

### Reachable

TODO: <https://git-scm.com/docs/gitglossary#def_reachable>

### Rebase

TODO

See [Rebase](rebase.md).

### Reference

Aka "ref", "ref name".

A _ref_ is a name that points to an [object name](#object-name) or a
[symbolic reference](#symbolic-reference-symref).
They're used to refer to [commits](#commit-noun) and other objects in the
[object database](#object-database).

See [Ref](ref.md).

Source: <https://git-scm.com/docs/gitglossary#def_ref>

### Reflog

Reference log.

TODO

See [Reflog](reflog.md).

### Refspec

Official:

> A _refspec_ is used by [fetch](#fetch) and [push](#push) to describe the mapping between
  remote ref and local ref.

It is a string that defines the mapping between a local reference (ref) and a remote reference.
It forms the foundation of how repositories are synchronized by providing a way to tell
[fetch](#fetch) and [push](#push) commands which refs to update and how to update them.

Source: <https://git-scm.com/docs/gitglossary#def_refspec>

### Remote

TODO

Aka. "tracking remote", "remote repository", "tracked repository".

See [Remote](remote.md).

### Remote repository

TODO: <https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-remoterepository>

### Remote-tracking branch

> A [ref](#reference) that is used to follow changes from another [repository](#repository)
  \[(typically a [remote repository](#remote-repository))\].

Details:

- > It typically looks like `refs/remotes/foo/bar` (indicating that it tracks a branch named `bar`
    in a remote named `foo`), and matches the right-hand-side of a configured fetch
    [refspec](#refspec).
- > A remote-tracking branch should not contain direct modifications or have local commits
    made to it.

See [Branch](#branch), [Remote](remote.md).

Source: <https://git-scm.com/docs/gitglossary#def_remote-tracking_branch>

### Repository

Aka "repo".

Official definition:

> A collection of _refs_ together with an _object database_ containing all _objects_ which are
  reachable from the _refs_, possibly accompanied by meta data from one or more _porcelains_.
> A repository can share an _object database_ with other repositories via alternates mechanism
  \[(alternate object database)\]

Per GitHub Copilot (GPT-4.1):

> The complete history of the project, including all commits, branches, tags, and objects.
> It is stored in the `.git` directory and includes the database of all tracked changes.

### Resolve

TODO: <https://git-scm.com/docs/gitglossary#def_resolve>

### Revision parameter

A string input to a Git command that specifies, or resolves to, a commit, object, or commit range.

See [Ref](ref.md).

### Rewind

TODO: <https://git-scm.com/docs/gitglossary#def_rewind>

### Sequence editor

TODO

### Shallow clone

TODO: <https://git-scm.com/docs/gitglossary#def_shallow_clone>

### Shallow repository

TODO: <https://git-scm.com/docs/gitglossary#def_shallow_repository>

### Signed tag object

A [tag object](#tag-object) that contains a (PGP) signature.

Source: <https://git-scm.com/docs/gitglossary#def_tag_object>

### Stage

Per GitHub Copilot (GPT-4.1):

> To "stage" in Git means to add changes from your working directory to the index
> (also called the staging area), preparing them to be included in the next commit.
> This is typically done using the `git add` command.

### Stash

TODO

See [Index and Working tree](index-working-tree.md).

### Stash entry

TODO: <https://git-scm.com/docs/gitglossary#def_stash_entry>

### Submodule

> A submodule is a repository embedded inside another repository.
> The submodule has its own history; the repository it is embedded in is called a superproject.

See [Submodules](submodules.md).

Source: <https://git-scm.com/docs/gitglossary#def_submodule>

### Superproject

(sic)

TODO: <https://git-scm.com/docs/gitglossary#def_superproject>

See [Submodule](#submodule).

### Symbolic reference (symref)

It is a reference that is of the format `refs/some/thing` (instead of the
[object name](#object-name) aka "SHA-1 id" or "hash") and that, when referenced, it recursively
[dereferences](#symbolic-reference-dereference) to this reference.

> Symbolic references are manipulated with the `git-symbolic-ref` command.

Example of a _symref_: [HEAD](#head)

Source: <https://git-scm.com/docs/gitglossary#def_symref>

### Symbolic reference dereference

> The action of accessing the _reference_ pointed at by a [symbolic ref](#symbolic-reference-symref)
  (e.g. `HEAD`).
>
> _Recursive dereferencing_ involves repeating the aforementioned process on the resulting ref
  until a non-symbolic reference is found.

Source: <https://git-scm.com/docs/gitglossary#def_dereference>

### Tag (noun)

Official:

> A _ref_ under `refs/tags/` _namespace_ that points to an object of an arbitrary type
  (typically a tag points to either a [tag](#tag-object) or a [commit object](#commit-object)).
>
> In contrast to a head \[(named reference)\], a tag is not updated by the `commit` command.
>
> A tag is most typically used to mark a particular point in the commit ancestry [chain](#chain).

Source: <https://git-scm.com/docs/gitglossary#def_tag_object>

See [Tag](tag.md).

### Tag object

> An _object_ containing a _ref_ pointing to another _object_, which can contain a message
  just like a [commit object](#commit-object).

Source: <https://git-scm.com/docs/gitglossary#def_tag_object>

See [Tag](#tag-noun), [Signed tag object](#signed-tag-object).

### Tag object dereference

> The action of accessing the _object_ a _tag_ points at.
>
> Tags are _recursively dereferenced_ by repeating the operation on the result object until
  the result has either a specified _object type_ (where applicable) or any non-"tag" object type.
>
> A synonym for "recursive dereference" in the context of tags is _peel_.

Source: <https://git-scm.com/docs/gitglossary#def_dereference>

### Topic branch

TODO: <https://git-scm.com/docs/gitglossary#def_topic_branch>

### Trailer

TODO: <https://git-scm.com/docs/gitglossary#def_trailer>

### Tree

TODO: <https://git-scm.com/docs/gitglossary#def_tree>

### Tree object

TODO: <https://git-scm.com/docs/gitglossary#def_tree_object>

### Tree-ish

TODO: <https://git-scm.com/docs/gitglossary#def_tree-ish>

### Unborn

TODO: <https://git-scm.com/docs/gitglossary#def_unborn>

### Unmerged index

TODO: <https://git-scm.com/docs/gitglossary#def_unmerged_index>

### Unreachable object

TODO: <https://git-scm.com/docs/gitglossary#def_unreachable_object>

### Upstream branch

TODO: <https://git-scm.com/docs/gitglossary#def_upstream_branch>

### Working directory

Per GitHub Copilot (GPT-4.1):

> The folder on your filesystem where the files of your project are checked out.
> It contains the current versions of files that you're working on, reflecting the state of the
> repository at a specific commit or branch.
> Changes made here aren't tracked by Git until you stage and commit them.

### Working tree

Warning: don't confuse with "worktree".

Aka "working directory" (avoid).

Per the official Git book, section
[Getting Started - What is Git?](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F):

> \[It\] is a single checkout of one version of the project. These files are pulled out of the
  compressed database in the Git directory and placed on disk for you to use or modify.

Note: avoid using the term "working directory" to avoid confusion with:

- the general computing concept of the "current working directory" (i.e. `pwd`)
- the `.git` directory, which is the repository itself

See [Index and Working tree](index-working-tree.md).

Sources:

- <https://git-scm.com/docs/gitglossary#def_working_tree>

### Worktree

TODO: <https://git-scm.com/docs/gitglossary#def_worktree>
