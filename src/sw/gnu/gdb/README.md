# Software / GNU / GNU Debugger (GDB)

A battle-tested debugger initially released in 1986.

GDB has been described as:

- "The GNU Project debugger"
- "The standard debugger for the GNU operating system"
- "The GNU Source-Level Debugger"

## Resources

- Homepage: <https://www.sourceware.org/gdb/>
- Code repo: <https://sourceware.org/git/binutils-gdb.git>
- Releases:
  - Download: <https://www.sourceware.org/gdb/download/>
  - News: <https://www.sourceware.org/gdb/news/>
- Documentation: <https://www.sourceware.org/gdb/documentation/>
  - Wiki: <https://sourceware.org/gdb/wiki/>
  - Manual: <https://sourceware.org/gdb/current/onlinedocs/gdb>
  - FAQ: <https://sourceware.org/gdb/wiki/FAQ>
  - Wikipedia: <https://en.wikipedia.org/wiki/GNU_Debugger>

## A debugger

See: [debugger.md](../debugger.md)

## Features

### Supported languages

> GDB supports C, C++, D, Go, Objective-C, Fortran, OpenCL C, Pascal, Rust, assembly,
  Modula-2, and Ada.
>
> Some GDB features may be used in expressions regardless of the language you use.

The "following can be used with the constructs of any supported language":

- the GDB `@` and `::` operators
- the `{type}addr` construct

## Usage

You use GDB in a "session". See the
[official GDB sample session](https://sourceware.org/gdb/current/onlinedocs/gdb#Sample-Session).
