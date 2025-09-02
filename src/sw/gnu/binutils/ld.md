# Software / GNU / Binutils / `ld`

"The GNU linker", aka `gld`, `ld.bfd`.

It is a _static linker_, often invoked directly by a GCC compiler.

Its main purpose is to combine _object files_ and _libraries_ into executables and
_shared libraries_.

## Resources

- Manual: <https://sourceware.org/binutils/docs/ld/>

## Features

> `ld` combines a number of object and archive files, relocates their data and ties up
  _symbol references_. Usually the last step in compiling a program is to run `ld`.

- Supports (read, combine, and write), thanks to the general purpose
  [BFD libraries](https://sourceware.org/binutils/docs/ld/BFD.html):
  - many object file formats
  - many archive file formats
- Different formats may be linked together to produce any available kind of object file
- Provides diagnostics to help track down problems with object files and libraries:
  - Upon encountering an error, instead of abandoning execution immediately, like most linkers,
    `ld` will try to continue executing, thus helping the user to find remaining problems.
  - It may even generate an output file, which can be useful for debugging purposes.
- Explicit and total control over the linking process.
>
> `ld` accepts _Linker Command Language_ files written in a superset of AT&T's
  _Link Editor Command Language_ syntax, to provide explicit and total control over
  the linking process.

## Details

- Explicit and total control over the _linking process_ is provided by _linker scripts_.
- `ld` always uses a linker script, either the default one or one specified by the user.

### Linker script

- A file written in the _Linker Command Language_.
- This language is a superset of AT&T's _Link Editor Command Language_ syntax.

> The main purpose of the linker script is to describe how the _sections_ in the _input files_
  should be _mapped_ into the _output file_, and to control the _memory layout_ of the output file.
> \[Also,\] when necessary, the linker script can also direct the linker to perform many
  other operations, using the commands described below.
