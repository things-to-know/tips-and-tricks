# Make / Best practices

## Curly braces for variables

Use curly braces for variables, e.g. `${VAR}` instead of `$(VAR)`, to help code portability between
Make and Bash.

Warning: only do this for variables, not for functions, e.g. `$(shell ...)` or `$(wildcard ...)`,
nor for Make variables that would mean something different in Bash, or just wouldn't work.

## Use `$(shell ...)` instead of backticks

TODO

## Use `$(wildcard ...)` instead of `ls`

TODO

See [wildcard function](./path-name-expansion.md#function-wildcard).
