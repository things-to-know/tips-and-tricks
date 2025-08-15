# Software / APT / Sources

Source of the following information: `man sources.list` (on Ubuntu 25.04).

See also:

- `apt-get(8)`
- `apt.conf(5)`
- `/usr/share/doc/apt/acquire-additional-files.md.gz`

## Description

`sources.list`: List of configured APT data sources.

The source list `/etc/apt/sources.list` and the files contained in `/etc/apt/sources.list.d/`
are designed to support any number of active sources and a variety of source media.

The information available from the configured sources is acquired by `apt-get update`
(or by an equivalent command from another _APT front-end_).

Two different file formats are allowed: "one-line-style" and "deb822-style".

The files list have:

- for "one-line-style" format: one source per line,
- for "deb822-style" format: multi-line _stanzas_ defining one or more sources per stanza,
  with the most preferred source listed first (in case a single version is available from more
  than one source).

## Source list files directory

The `/etc/apt/sources.list.d` directory provides a way to add `sources.list` entries in
separate files.

The suggested filename for new systems is `/etc/apt/sources.list.d/vendor.sources`, where `vendor`
is the result of `dpkg-vendor --query Vendor | tr A-Z a-z`, in "deb822-style" format.
For example, Ubuntu uses `/etc/apt/sources.list.d/ubuntu.sources`.

Filenames rules:

- Must have the extension:
  - `.list`: for "one-line-style" format
  - `.sources`: for "deb822-style" format
- The filenames may only contain: alphanumeric (`[a-zA-Z0-9]`), `_`, `-` and `.` characters;
  otherwise APT will print a notice that it has ignored a file (unless that file matches a pattern
  in the `Dir::Ignore-Files-Silently` config list, in which case it will be silently ignored).

## Format

### Particular to "deb822-style"

Notes:

- This is a new format supported by APT itself since version 1.1.
  Previous versions ignore such files with a notice message.
- It is intended to make this format gradually the default format, deprecating the
  "one-line-style format", as it is easier to create, extend and modify for humans and machines
  alike especially if a lot of sources and/or options are involved.

Files in this format have the extension `.sources`.

The format is similar in syntax to other files used by Debian and its derivatives, such as
the metadata files that APT will download from the configured sources or the
_debian/control file_ in a _Debian source package_.

Individual entries are separated by an empty line; additional empty lines are ignored,
and a `#` at the start of the line marks the entire line as a comment.
It is usually easier to add the field `Enabled: no` to the stanza to disable the entry.

Options have the same syntax as every other field: a field name separated by a `:` and,
optionally, spaces from its value(s).

Note especially that multiple values are separated by whitespace (like spaces, tabs and newlines),
**not by commas as in the one-line format**.
Multi-value fields like `Architectures` also have `Architectures-Add` and `Architectures-Remove`
to modify the default value rather than replacing it.

### Particular to "one-line-style"

Warning: This format is deprecated and may eventually be removed, but not before 2029.

This is the traditional format and supported by all apt versions.

Files in this format have the extension `.list`.

Each line specifying a source starts with a type (e.g. `deb-src`) followed by options and
arguments for this type. Individual entries cannot be continued onto a following line.

Empty lines are ignored, and a `#` character anywhere on a line marks the remainder
of that line as a comment. Consequently an entry can be disabled by commenting out
the entire line.

If options should be provided they are separated by spaces and all of them together are enclosed
by `[]` included in the line after the type separated from it with a space.
If an option allows multiple values these are separated from each other with a `,`.
An option name is separated from its value(s) by a `=`.
Multi-value options also have `-=` and `+=` as separators, which instead of replacing the default
with the given value(s) modify the default value(s) to remove or include the given values.

Note that not all options as described below are supported by all apt versions.
Note also that some older applications parsing this format on their own might not expect
to encounter options as they were uncommon before the introduction of multi-architecture
support.

### General format

- `deb` type:
  - References a typical two-level Debian archive, distribution/component.
    - `distribution`: generally a suite name like `stable` or `testing`, or a codename like
      `trixie` or `forky`
    - `component`: one of `main`, `contrib`, `non-free` or `non-free-firmware`
- `deb-src` type:
  - References a Debian distribution's source code in the same form as the `deb` type.
  - A `deb-src` line is required to fetch _source indexes_.

The format for two "one-line-style" entries using the `deb` and `deb-src` types is:

```text
deb [ option1=value1 option2=value2 ] uri suite [component1] [component2] [...]
deb-src [ option1=value1 option2=value2 ] uri suite [component1] [component2] [...]
```

Alternatively the equivalent entry in "deb822 style" looks like this:

```text
Types: deb deb-src
URIs: uri
Suites: suite
Components: [component1] [component2] [...]
option1: value1
option2: value2
```

- The URI for the `deb` type must specify the base of the Debian distribution, from which APT
  will find the information it needs.

- `suite`:
  - It can specify an exact path, in which case the components must be omitted and `suite`
    must end with a `/`. This is useful for the case when only a particular sub-directory of the
    archive denoted by the URI is of interest.
  - If `suite` does not specify an exact path, at least one `component` must be present.
  - It may also contain the variable `$(ARCH)`, which expands to the Debian architecture (such as
    `amd64` or `armel`) used on the system. This permits architecture-independent `sources.list`
    files to be used. In general this is only of interest when specifying an exact path; APT will
    automatically generate a URI with the current architecture otherwise.

Especially in the "one-line-style format" since only one distribution can be specified per line
it may be necessary to have multiple lines for the same URI, if a subset of all available
distributions or components at that location is desired.

APT will sort the URI list after it has generated a complete set internally, and will collapse
multiple references to the same Internet host, for instance, into a single connection, so that
it does not inefficiently establish a connection, close it, do something else, and then
re-establish a connection to that same host.

APT also parallelizes connections to different hosts to more effectively deal with sites with
low bandwidth.

It is important to **list sources in order of preference**, with the most preferred source listed
first. Typically this will result in sorting by speed from fastest to slowest (CD-ROM followed
by hosts on a local network, followed by distant Internet hosts, for example).

As an example, the sources for your distribution could look like this in the
deprecated "one-line-style" format:

```text
deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://archive.ubuntu.com/ubuntu plucky main restricted
deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://security.ubuntu.com/ubuntu plucky-security main restricted
deb [signed-by=/usr/share/keyrings/ubuntu-archive-keyring.gpg] http://us.archive.ubuntu.com/ubuntu plucky-updates main restricted
```

or like this in "deb822-style" format:

```text
Types: deb
URIs: http://us.archive.ubuntu.com/ubuntu
Suites: plucky plucky-updates
Components: main restricted
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: http://security.ubuntu.com/ubuntu
Suites: plucky-security
Components: main restricted
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

## Options

Each source entry can have options specified to modify which source is accessed and how data
is acquired from it. Format, syntax and names of the options vary between the "one-line-style"
and "deb822-style" formats as described, but they both have the same options available.

For simplicity we list the "deb822" field name and provide the "one-line" name in brackets.
Remember that besides setting multi-value options explicitly, there is also the option to modify
them based on the default, but we aren't listing those names explicitly here.
Unsupported options are **silently ignored** by all APT versions.

- `Architectures` (`arch`):
  - A multi-value option defining for which architectures information should be downloaded.
  - If this option isn't set the default is all architectures as defined by the
    `APT::Architectures` config option.

- `Languages` (`lang`):
  - A multi-value option defining for which languages information such as translated package
    descriptions should be downloaded.
  - If this option isn't set, the default is all languages as defined by the `Acquire::Languages`
    config option.

- `Targets` (`target`):
  - A multi-value option defining which download targets APT will try to acquire from this source.
  - If not specified, the default set is defined by the `Acquire::IndexTargets` config scope
    (targets are specified by their name in the `Created-By` field).
  - Additionally, targets can be enabled or disabled by using the `Identifier` field as an option
    with a boolean value instead of using this multi-value option.

- `PDiffs` (`pdiffs`):
  - A yes/no value which controls if APT should try to use _PDiffs_ to update old indexes
    instead of downloading the new indexes entirely.
  - The value of this option is ignored if the repository doesn't announce the availability of
    _PDiffs_.
  - Defaults to the value of the option with the same name for a specific index file defined
    in the `Acquire::IndexTargets` scope, which itself defaults to the value of config option
    `Acquire::PDiffs` which defaults to `yes`.

- `By-Hash` (`by-hash`):
  - Controls if APT should try to acquire indexes via a URI constructed from a hashsum of the
    expected file instead of using the well-known stable filename of the index.
    Using this can avoid hashsum mismatches, but requires a supporting mirror.
  - Value `yes`: activates the use of this feature if this source indicates support for it
  - Value `no`: disables the use of this feature if this source indicates support for it
  - Value `force`: enables the feature regardless of what the source indicates.
  - Defaults to the value of the option of the same name for a specific index file defined
    in the `Acquire::IndexTargets` scope, which itself defaults to the value of config
    option `Acquire::By-Hash` which defaults to `yes`.

Furthermore, there are options which if set affect all sources with the same URI and Suite,
so they have to be set on all such entries and can not be varied between different components.
APT will try to detect and error out on such anomalies.

- `Allow-Insecure` (`allow-insecure`),
  `Allow-Weak` (`allow-weak`) and
  `Allow-Downgrade-To-Insecure` (`allow-downgrade-to-insecure`):
  - Boolean values which all default to `no`.
  - Value `yes`: they circumvent parts of `apt-secure(8)` and should therefore not be used lightly!

- `Trusted` (`trusted`):
  - A tri-state value which defaults to APT deciding if a source is considered trusted or if
    warnings should be raised before e.g. packages are installed from this source.
    This option can be used to override that decision.
  - Value `yes`: tells APT always to consider this source as trusted, even if it doesn't pass
    authentication checks.
    It disables parts of `apt-secure(8)`, and should therefore only be used in a local and trusted
    context (if at all) as otherwise security is breached.
  - Value `no`: does the opposite, causing the source to be handled as untrusted even if the
    authentication checks passed successfully.
  - The default value can't be set explicitly.

- `Signed-By` (`signed-by`):
  - An option to require a repository to pass `apt-secure(8)` verification with a certain set
    of keys rather than all trusted keys apt has configured.
  - It is specified as a list of absolute paths to keyring files (have to be accessible and
    readable for the `_apt` _system user_, so ensure everyone has read-permissions on the file)
    and fingerprints of keys to select from these keyrings.
  - The recommended locations for keyrings are:
    - `/usr/share/keyrings`: for keyrings managed by packages
    - `/etc/apt/keyrings`: for keyrings managed by the system operator
  - If no keyring files are specified, the default is the `trusted.gpg` keyring and all keyrings
    in the `trusted.gpg.d/` directory.
  - If no fingerprint is specified, all keys in the keyrings are selected.
  - A fingerprint will accept also all signatures by a subkey of this key.
    If this isn't desired, an exclamation mark (`!`) can be appended to the fingerprint to disable
    this behavior.
  - The option defaults to the value of the option with the same name if set in the previously
    acquired `Release` file of this repository (only fingerprints can be specified there through).
    Otherwise all keys in the trusted keyrings are considered valid signers for this repository.
  - The option may also be set directly to an embedded GPG public key block.
    Special care is needed to encode the empty line with leading spaces and `.`:

    ```text
    Types: deb
    URIs: https://deb.debian.org
    Suites: stable
    Components: main contrib non-free non-free-firmware
    Signed-By:
    -----BEGIN PGP PUBLIC KEY BLOCK-----
    .
    mDMEYCQjIxYJKwYBBAHaRw8BAQdAD/P5Nvvnvk66SxBBHDbhRml9ORg1WV5CvzKYCuMfoIS0BmFiY2Rl
    ZoiQBBMWCgA4FiEErCIG1VhKWMWo2yfAREZd5NfO31cFAmAkIyMCGyMFCwkIBwMFFQoJCAsFFgIDAQAC
    HgECF4AACgkQREZd5NfO31fbOwD6ArzSdM0Dkd5h2Ujy1b6KcAaVW9FOa5UNfJ9FFBtjLQEBAJ7UyWD3
    dZzhvlaAwunsk7DG3bHcln8DMpIJVXht78sL=IE0r
    -----END PGP PUBLIC KEY BLOCK-----
    ```

### Time-related options

- `Check-Valid-Until` (`check-valid-until`): TODO

- `Valid-Until-Min` (`valid-until-min`) and
  `Valid-Until-Max` (`valid-until-max`): TODO

- `Check-Date` (`check-date`): TODO

- `Date-Max-Future` (`date-max-future`): TODO

- `InRelease-Path` (`inrelease-path`): TODO

- `Snapshot` (`snapshot`): TODO

## URI Specification

The currently recognized URI types are:

- `http` (`apt-transport-http(1)`)
  - The `http` scheme specifies an HTTP server for an archive and is the most commonly used method.
    The URI can directly include login information if the archive requires it, but the use of
    `apt_auth.conf(5)` should be preferred.
    The method also supports SOCKS5 and HTTP(S) proxies either configured via apt-specific
    config or specified by the environment variable `http_proxy` in the format
    (assuming an HTTP proxy requiring authentication) `http://user:pass@server:port/`.
    The authentication details for proxies can also be supplied via `apt_auth.conf(5)`.

  - Note that these forms of authentication are insecure as the whole communication with the
    remote server (or proxy) is not encrypted so a sufficiently capable attacker can observe
    and record login as well as all other interactions.
    The attacker can not modify the communication through as APT's data security model is
    independent of the chosen transport method. See `apt-secure(8)` for details.

- `https` (`apt-transport-https(1)`)
  - Specifies an HTTPS server for an archive and is very similar in use and available options
    to the `http` scheme. The main difference is that the communication between APT and server
    (or proxy) is encrypted.
  - Note: encryption doesn't prevent an attacker from knowing which server (or proxy) APT is
    communicating with, and deeper analysis can potentially still reveal which data was
    downloaded. If this is a concern, the Tor-based schemes mentioned further below might be
    a suitable alternative.

- `mirror`, `mirror+scheme` (`apt-transport-mirror(1)`)
  - Specifies the location of a `mirrorlist`.
  - By default the scheme used for the location is `http`, but any other scheme can be used via
    `mirror+scheme`.
  - The `mirrorlist` itself can contain many different URIs for mirrors the APT client can
    transparently pick, choose and fallback between intended to help both with distributing
    the load over the available mirrors and ensuring that clients can acquire data even if
    some configured mirrors are not available.

- `file`:
  - It allows an arbitrary directory in the file system to be considered an archive.
  - This is useful for _NFS mounts_ and local mirrors or archives.

- `cdrom`:
  - It allows APT to use a local CD-ROM, DVD or USB drive with media swapping.
  - Use the `apt-cdrom(8)` program to create `cdrom` entries in the source list.

- `copy`:
  - It is identical to the `file` scheme except that packages are copied into the
    _cache directory_ instead of used directly at their location.
  - It is useful for people using removable media to copy files around with APT.

- adding more recognizable URI types:
  - APT can be extended with more methods shipped in other optional packages, which should follow
    the naming scheme `apt-transport-{method}`.
  - For instance, the APT team also maintains the package `apt-transport-tor`, which provides
    access methods for HTTP and HTTPS URIs routed via the Tor network.

## Examples

Uses the archive stored locally (or NFS mounted) at `/home/apt/debian` for
`stable/main`, `stable/contrib`, `stable/non-free` and `stable/non-free-firmware`.

```text
deb file:/home/apt/debian stable main contrib non-free non-free-firmware

Types: deb
URIs: file:/home/apt/debian
Suites: stable
Components: main contrib non-free non-free-firmware
```

As above, except this uses the `unstable` (development) distribution.

```text
deb file:/home/apt/debian unstable main contrib non-free non-free-firmware

Types: deb
URIs: file:/home/apt/debian
Suites: unstable
Components: main contrib non-free non-free-firmware
```

Sources specification for the above.

```text
deb-src file:/home/apt/debian unstable main contrib non-free non-free-firmware

Types: deb-src
URIs: file:/home/apt/debian
Suites: unstable
Components: main contrib non-free non-free-firmware
```

The first line gets package information for the architectures in `APT::Architectures` while
the second always retrieves `amd64` and `armel`.

```text
deb http://deb.debian.org/debian trixie main
deb [ arch=amd64,armel ] http://deb.debian.org/debian trixie main

Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie
Components: main

Types: deb
URIs: http://deb.debian.org/debian
Suites: trixie
Components: main
Architectures: amd64 armel
```

Uses HTTP to access the archive at `archive.debian.org`, and uses only the `hamm/main` area.

```text
deb http://archive.debian.org/debian-archive hamm main

Types: deb
URIs: http://archive.debian.org/debian-archive
Suites: hamm
Components: main
```

Uses HTTPS to access the archive at `deb.debian.org`, under the `debian` directory, and uses
only the `trixie/contrib` area.

```text
deb https://deb.debian.org/debian trixie contrib

Types: deb
URIs: https://deb.debian.org/debian
Suites: trixie
Components: contrib
```

Uses HTTPS to access the archive at `deb.debian.org`, under the `debian` directory, and uses only
the `unstable/contrib` area.
If this line appears as well as the one in the previous example in `sources.list`, a single HTTPS
session will be used for both resource lines.

```text
deb https://deb.debian.org/debian unstable contrib

Types: deb
URIs: https://deb.debian.org/debian
Suites: unstable
Components: contrib
```

Uses HTTP to access the archive at `ftp.tlh.debian.org`, under the `universe` directory, and uses
only files found under `unstable/binary-i386` on `i386` machines, `unstable/binary-amd64` on
`amd64`, and so forth for other supported architectures.
Note: this example only illustrates how to use the substitution variable; official debian archives
are not structured like this.

```text
deb http://ftp.tlh.debian.org/universe unstable/binary-$(ARCH)/

Types: deb
URIs: http://ftp.tlh.debian.org/universe
Suites: unstable/binary-$(ARCH)/
```

Uses HTTP to get binary packages as well as sources from the `stable`, `testing` and `unstable`
suites and the components `main` and `contrib`.

```text
deb http://deb.debian.org/debian stable main contrib
deb-src http://deb.debian.org/debian stable main contrib
deb http://deb.debian.org/debian testing main contrib
deb-src http://deb.debian.org/debian testing main contrib
deb http://deb.debian.org/debian unstable main contrib
deb-src http://deb.debian.org/debian unstable main contrib

Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: stable testing unstable
Components: main contrib
```

Uses a specific timestamp for Snapshots.

```text
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: stable testing unstable
Snapshot: 20250311T030104Z
Components: main contrib
```

Doesn't allow the optional parameter `--snapshot`.

```text
Types: deb deb-src
URIs: http://deb.debian.org/debian-security
Suites: stable-security
Snapshot: disable
Components: main contrib non-free-firmware
```
