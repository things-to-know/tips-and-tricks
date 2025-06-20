# Make / Variables

TODO

## Special variables

TODO

Docs:
make Manual /
[Other Special Variables](https://www.gnu.org/software/make/manual/html_node/Special-Variables.html)

- `.DEFAULT_GOAL`
- `.FEATURES`
- `.INCLUDE_DIRS`
- `.VARIABLES`
- `MAKE_TERMERR`
- `MAKE_TERMOUT`
- `MAKEFILE_LIST`:
  > [...] name of each makefile that is parsed by make, in the order in which it was parsed.
  [source](https://www.gnu.org/software/make/manual/html_node/Special-Variables.html#index-makefiles_002c-and-MAKEFILE_005fLIST-variable)
- `SHELL`: see [SHELL](#shell)

### `SHELL`

Docs:
<https://www.gnu.org/software/make/manual/html_node/Choosing-the-Shell.html>

Default: `/bin/sh`

**Warning**: the behavior of make regarding `SHELL` is different in MS Windows vs.
Unix-like systems.

> Unlike most variables, **the variable `SHELL` is never set from the environment**.
  This is because the `SHELL` environment variable is used to specify your personal choice of
  shell program for interactive use. It would be very bad for personal choices like this to
  affect the functioning of makefiles.
>
> Furthermore, when you do set `SHELL` in your makefile that value is not exported in the
  environment to recipe lines that make invokes.
> Instead, the value inherited from the user's environment, if any, is exported. You can
  override this behavior by explicitly exporting `SHELL` (see Communicating Variables to a
  Sub-make), forcing it to be passed in the environment to recipe lines.
> **However, on MS-DOS and MS-Windows the value of `SHELL` in the environment is used**, since
  on those systems most users do not set this variable, and therefore it is most likely set
  specifically to be used by make. On MS-DOS, if the setting of SHELL is not suitable for make,
  you can set the variable `MAKESHELL` to the shell that make should use; if set it will be used
  as the shell instead of the value of `SHELL`.
