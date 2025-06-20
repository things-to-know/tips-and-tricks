# Make / Path name expansion

_Path name expansion_ is also known as: _globbing_, _filename expansion_, _wildcard expansion_.

> A single file name can specify many files using _wildcard characters_.

Where and how wildcard expansion happens:

- In _targets_: performed by make automatically
- In _prerequisites_: performed by make automatically
- In _recipes_: performed by the shell
- In other contexts: happens only if you request it explicitly with the
  [`wildcard` function](#function-wildcard)

See make manual:
- [Using Wildcard Characters in File Names](https://www.gnu.org/software/make/manual/html_node/Wildcards.html)
- [Pitfalls of Using Wildcards](https://www.gnu.org/software/make/manual/html_node/Wildcard-Pitfall.html>)
- [Wildcard Examples](https://www.gnu.org/software/make/manual/html_node/Wildcard-Examples.html)

## Wildcard characters

Wildcard characters: `*`, `?` and `[…]`, the same as in Bash.

The character `~` is "special" if present at the beginning of a filename.
Unfortunately, **the behavior depends** on the characters after it, and also on the system.
Be kind and avoid using it; use `$HOME` instead.

## Function `wildcard`

Docs:
- <https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html>
- <https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html#index-wildcard-2>
