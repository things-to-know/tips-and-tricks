# Software / Ubuntu / Releases

## Resources

### News

- New releases and updates:
  <https://fridge.ubuntu.com/category/release/>
- EOL (End of Life) announcements:
  <https://fridge.ubuntu.com/category/release/eol/>
- Ubuntu Announcements mailing list:
  <https://lists.ubuntu.com/archives/ubuntu-announce/>

The [official blog website](https://ubuntu.com/blog) is less technical and more focused on
news, events, etc.

### Downloads

- Latest Ubuntu release (LTS and non-LTS):
  - Desktop: <https://ubuntu.com/download/desktop>
  - Server: <https://ubuntu.com/download/server>

### Archive

- Releases (most versions):
  <https://releases.ubuntu.com/>
- List of all releases, including patch versions, with links to their release notes:
  <https://wiki.ubuntu.com/Releases>

## Information

Release schedule and lifecycle (including long-term support (LTS) editions):

> In 2006 we decided that every fourth release, made every two years, would receive long-term
> support for large-scale deployments. This is the origin of the term LTS for stable,
> maintained releases.

[[Source](https://ubuntu.com/about)]

### Lifecycle

Source: <https://ubuntu.com/about/release-cycle>

> Version numbers are `YY.MM`
>
> Releases of Ubuntu get a development codename (_Plucky Puffin_) and are versioned by the year
> and month of delivery—for example, Ubuntu 25.04 was released in April 2025.

#### LTS releases

> LTS or _Long-Term Support_ releases are published **every two years in April**.
>
> LTS releases are the _enterprise grade_ releases of Ubuntu and are used the most.
>
> Ubuntu LTS releases receive 5 years of standard security maintenance for all packages in the
> _Main_ repository.

#### Interim releases

> Every six months between LTS versions, Canonical publishes an _interim release_ of Ubuntu,
> \[e.g. 25.04\]. These are **production-quality releases** and are **supported for 9 months**,
> with sufficient time provided for users to update, but these releases **do not receive the
> long-term commitment** of LTS releases.

### Components

> A release of Ubuntu is made through several different channels. What you consume will depend
> on where you are and what your interests happen to be.

- _deb packages_ (aka _debs_): the standard package format for [Debian](../debian/index.md) and Ubuntu
  > [...] tested and integrated so that they work well as a set.
  > _Debs_ are optimized for highly structured _dependency management_, enabling you to combine
  > _debs_ very richly while ensuring that the necessary _software dependencies_ for each _deb_
  > (themselves delivered as _debs_) are installed on your machine.
- _snap packages_ (aka _snaps_): a newer package format that is designed to work across
  different Linux distributions, providing a more isolated and secure environment for applications
  > more suited for third-party applications and tools which evolve at their own speed, independently of Ubuntu. If you want to install a high-profile app like Firefox or a toolchain like the latest version of Golang, you probably want the snap because it will give you fresher versions and more control of the specific major versions you want to track.
- images
- containers
