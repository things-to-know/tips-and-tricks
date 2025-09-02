# Software / GNU / Binutils / GNU `as`

"AS - the portable GNU assembler"

Note: it is not one assembler, but a family of assemblers.

> `as` is primarily intended to assemble the output of the GNU C compiler `gcc` for use by
  the linker `ld`.

## Resources

- Manual: <https://sourceware.org/binutils/docs/as/>

## Usage

- "Each time you run `as` it assembles exactly one source program"
- "The source program is made up of one or more files"
  - "The standard input is also a file"

## Output

> Every time you run `as` it produces an _output file_, which is your _assembly language program_
  translated into numbers. This file is the _object file_.
> Conventionally, object file names end with `.o`.
>
> The object file is meant for input to the linker `ld`.

It contains:

- "_assembled program code_",
- "information to help `ld` integrate the _assembled program_ into a _runnable file_", and
- "(optionally) _symbolic information_ for the _debugger_".

The default name of the _object file_ is `a.out`, which is unfortunate, and doesn't comply with
modern conventions.

> The default name is used for **historical reasons**: older assemblers were capable of
  assembling self-contained programs directly into a runnable program.

## Details

> If you use (or have used) the GNU assembler on one architecture, you should find a fairly
  similar environment when you use it on another architecture.
>
> Each version has much in common with the others, including _object file formats_, most
  _assembler directives_ (often called _pseudo-ops_) and _assembler syntax_.
>
> Nevertheless, we've tried to make `as` assemble correctly everything that
  other assemblers for the same machine would assemble.
  Any exceptions are documented explicitly.
>
> This doesn't mean `as` always uses the same syntax as another assembler for the same
  architecture; for example, we know of several incompatible versions of
  `680x0` _assembly language syntax_.
