# Software / GNU / GNU Binutils

GNU Binutils is a collection of tools for creating and manipulating executable binaries.

## Resources

- Homepage: <https://www.gnu.org/software/binutils/>
- Code repo: <https://sourceware.org/git/binutils-gdb.git>
- Documentation: <https://sourceware.org/binutils/docs/>

## Relation to GCC and other GNU software

While closely related to GCC, GNU Binutils is a separate project and not actually part of GCC.
The tools in Binutils can be used with or without a compiler, although they are often installed
and used together with GCC.

## The meta-project

The GNU Binutils project is

> [...] part of a larger meta-project intended to provide users with all the tools that
  they might need in order to create programs and applications of their own.

Tools like the GCC compilers, the GLIBC library and [GDB](../gdb/README.md) (debugger)
are also part of this meta-project.

> [...] their main reason for existence is to give the GNU system (and GNU/Linux) the facility
  to compile and link programs.

What's necessary, then, are at least the following tools:

- an [_assembler_](https://en.wikipedia.org/wiki/Assembly_language#Assembler)
- a _linker_
- a [_disassembler_](https://en.wikipedia.org/wiki/Disassembler)

Other tools are also necessary to provide a complete toolchain.

## Main tools

- Assemblers:
  - [`as`](./as.md) (aka `gas`): "the GNU Assembler" (a family of assemblers, actually)
- Linkers:
  - [`ld`](./ld.md): "the GNU linker"
  - `gold`: "a new, faster, ELF-only linker"

## Key features

It includes:

- Assemblers:
  - [`as`](./as.md) (aka `gas`): "the GNU Assembler" (a family of assemblers, actually)
- Linkers:
  - [`ld`](./ld.md): "the GNU linker"
  - `gold`: "a new, faster, ELF-only linker"
- Tools for creating archives:
  - `ar`: "creates, modifies, and extracts from archives"
    <https://sourceware.org/binutils/docs/binutils/ar.html>
  - `ranlib`: "generates an index to the contents of an archive and stores it in the archive"
    <https://sourceware.org/binutils/docs/binutils/ranlib.html>
- Profilers:
  - `gprof`: "the GNU profiler"
  - `gprofng`: "the next generation profiler for Linux"
- Binary inspection tools:
  - `addr2line`: "translates addresses or _symbol+offset_ into file names and line numbers"
  - `nm`: "lists the symbols from object files"
  - `objdump`: display information about object files
  - `readelf`: display information about object files in ELF format
  - `size`: list the total size of each object file and its sections
  - `strings`: useful for determining the contents of non-text files
- Binary manipulation tools:
  - `elfedit`: "updates the ELF header and program property of ELF files which have the matching
    ELF machine and file types"
  - `objcopy`: "copies the contents of an object file to another" (different file format)
  - `strip`: discard all symbols from given object files
- "Tool for _demangling_ mangled names":
  - `c++filt`: to demangle symbols (mostly C++ and Java) with the same name
- Libraries related to binary files:
  - `libbfd`: "for manipulating binary files in a variety of different formats"
  - `libopcodes`: "for assembling and disassembling a variety of different assembler languages"
  - `libctf`: "for manipulating the CTF debug format"
  - `libsframe`: "for manipulating the SFRAME debug format"
- Windows-related tools:
  - `dlltool`: "create the files needed to create dynamic link libraries (DLLs)"
  - `dllwrap`: deprecated; use `ld --shared` instead
  - `windres`: for manipulating Windows resources
  - `windmc`: for generating Windows message resource files

Note:

> Most of these programs use _BFD_ (the "Binary File Descriptor library"), to do
  low-level manipulation.

Demangling:

> \[decoding\] low-level names into user-level names so that they can be read.
