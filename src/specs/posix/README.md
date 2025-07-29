# POSIX

TODO

- [POSIX Signals](posix-signals.md)

## About

See: <https://en.wikipedia.org/wiki/POSIX>

> A family of standards specified by the IEEE Computer Society for maintaining compatibility
  between [operating systems](#operating-system)
>
> POSIX defines APIs, along with command line shells and utility interfaces,
  for software compatibility (portability) with variants of Unix and other operating systems.

> Unix was selected as the basis for a standard system interface partly because it was
  "manufacturer-neutral". However, several major versions of Unix existed—so there was
  a need to develop a common-denominator system.
>
> The POSIX specifications for Unix-like operating systems originally consisted of a
  single document for the core programming interface, but eventually grew to 19 separate
  documents (POSIX.1, POSIX.2, etc.).

Components and history:

- > The standardized user command line and scripting interface were based on the
    UNIX System V shell.
- > Many user-level programs, services and utilities (including awk, echo, ed) were also
    standardized, along with required program-level services (including basic I/O:
    file, terminal and network).
- > POSIX also defines a standard threading library API which is supported by most modern
    operating systems.

Result:

> In 2008, most parts of POSIX were combined into a single standard
  (IEEE Std 1003.1-2008, aka POSIX.1-2008).

## Versions

Latest (as of 2025-05-22): "POSIX.1-2024", which is also denominated (somewhat confusingly):
"The Open Group Base Specifications Issue 8", and "IEEE Std 1003.1 - 2024 Edition".

Full specification: <https://pubs.opengroup.org/onlinepubs/9799919799/>

### POSIX.1-2024

> POSIX.1-2024 defines a standard operating system interface and environment, including a
> command interpreter (or "shell"), and common utility programs to support applications
> portability at the source code level.
>
> POSIX.1-2024 is intended to be used by both application developers and system implementors
> and comprises four major components (each in an associated volume).

#### Volumes

[Base Definitions volume (XBD)](https://pubs.opengroup.org/onlinepubs/9799919799/idx/xbd.html):

> General terms, concepts and interfaces common to all volumes of this standard, including
  utility conventions and C-language header definitions.

[System Interfaces volume (XSH)](https://pubs.opengroup.org/onlinepubs/9799919799/idx/xsh.html):
> Definitions for system service functions and subroutines, language-specific system services
  for the C programming language, function issues, including portability, error handling,
  and error recovery.

[Shell and Utilities volume (XCU)](https://pubs.opengroup.org/onlinepubs/9799919799/idx/xcu.html):

> Definitions for a standard source code-level interface to command interpretation services
  (a "shell") and common utility programs for application programs.

[Rationale (Informative) volume (XRAT)](https://pubs.opengroup.org/onlinepubs/9799919799/idx/xrat.html):

> Extended rationale that did not fit well into the rest of the document structure,
  which contains historical information concerning the contents of POSIX.1-2024
  and why features were included or discarded by the standard developers.

#### Out of Scope

> The following areas are outside the scope of POSIX.1-2024:
>
> - Graphics interfaces
> - Database management system interfaces
> - Record I/O considerations
> - Object or binary code portability
> - System configuration and resource availability

> POSIX.1-2024 describes the external characteristics and facilities that are of importance
  to application developers, rather than the internal construction techniques employed to
  achieve these capabilities.
> Special emphasis is placed on those functions and facilities that are needed in a wide variety
  of commercial applications.

## Standards

### Command-line shell and scripting interface

TODO

### Utilities

TODO

### Program-level services

TODO

### Threading library

TODO

## POSIX-oriented operating systems

Linux distributions are, at most, "mostly posix-compliant". Only a few operating systems
are POSIX-certified. The only popular one (for end-users) is macOS.

FreeBSD, NetBSD, OpenBSD **aren't POSIX-certified**.

<https://en.wikipedia.org/wiki/POSIX#POSIX-oriented_operating_systems>
