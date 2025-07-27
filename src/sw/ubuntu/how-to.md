# Software / Ubuntu / How-to

## Installation

### Download and verify an image

References:

- <https://ubuntu.com/tutorials/how-to-verify-ubuntu>

Files to download (examples with parameters: `ubuntu_version=24.04.2`, `computer_architecture=amd64`):

- image (ISO file):
  `https://releases.ubuntu.com/${ubuntu_version}/ubuntu-${ubuntu_version}-desktop-${computer_architecture}.iso`
  ([example](https://releases.ubuntu.com/24.04.2/ubuntu-24.04.2-desktop-amd64.iso))
- images' checksum (one file for all the available images):
  `https://releases.ubuntu.com/${ubuntu_version}/SHA256SUMS`
  ([example](https://releases.ubuntu.com/24.04.2/SHA256SUMS))
- signature (GnuPG) of the images' checksum file:
  `https://releases.ubuntu.com/${ubuntu_version}/SHA256SUMS.gpg`
  ([example](https://releases.ubuntu.com/24.04.2/SHA256SUMS.gpg))

#### Script

Parameters:

```sh
ubuntu_version=24.04.2
computer_architecture=amd64

iso_filename="ubuntu-${ubuntu_version}-desktop-${computer_architecture}.iso"
iso_checksum_filename='SHA256SUMS'
iso_checksum_gpg_filename='SHA256SUMS.gpg'
releases_file_server_host='releases.ubuntu.com'

iso_download_url="https://${releases_file_server_host}/${ubuntu_version}/${iso_filename}"
iso_checksum_download_url="https://${releases_file_server_host}/${ubuntu_version}/${iso_checksum_filename}"
iso_checksum_gpg_download_url="https://${releases_file_server_host}/${ubuntu_version}/${iso_checksum_gpg_filename}"
```

Download files:

```sh
wget "${iso_checksum_download_url}"
wget "${iso_checksum_gpg_download_url}"
wget "${iso_download_url}"
```

Verify integrity of the image file:

```sh
echo "d7fe3d6a0419667d2f8eff12796996328daa2d4f90cd9f87aa9371b362f987bf *ubuntu-24.04.2-desktop-amd64.iso" \
    | shasum --algorithm 256 --check --strict

echo "${SW_DOWNLOAD_CHECKSUM_VALUE}  ${SW_DOWNLOAD_FILENAME}" > "${SW_DOWNLOAD_CHECKSUM_POSTPROCESS_FILENAME}"
shasum --algorithm 256 --check --strict "${SW_DOWNLOAD_CHECKSUM_POSTPROCESS_FILENAME}"
```

```zsh
echo "d7fe3d6a0419667d2f8eff12796996328daa2d4f90cd9f87aa9371b362f987bf *ubuntu-24.04.2-desktop-amd64.iso" \
    | shasum -a 256 --check --strict
```

```text
ubuntu-24.04.2-desktop-amd64.iso: OK
```

Verify the signature (`SHA256SUMS.gpg`) of the checksum file (`SHA256SUMS`):

```zsh
gpg --keyid-format long --verify \
    "${iso_checksum_gpg_filename}" \
    "${iso_checksum_filename}"
```

```text
gpg: Signature made jue 20 feb 2025 12:25:00 UTC
gpg:                using RSA key 843938DF228D22F7B3742BC0D94AA3F0EFE21092
gpg: Good signature from "Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>" [full]
```

If you get an error like this:

> gpg: Can't check signature: No public key

then you need to import the (public) key used to generate the signature file
(see [Import Ubuntu Releases' GPG keys](#import-ubuntu-releases-gpg-keys)).

### Import Ubuntu Releases' GPG keys

Note: As of 2025-06-30, they valid IDs are `46181433FBB75451` (hex) and `D94AA3F0EFE21092` (hex)
[[source](https://ubuntu.com/tutorials/how-to-verify-ubuntu#4-retrieve-the-correct-signature-key)].

Warning: according to Ubuntu's
[official tutorial](https://ubuntu.com/tutorials/how-to-verify-ubuntu) on this topic:

> We use GnuPG's "long" (64-bit) key IDs throughout this tutorial, since "short" (32-bit)
> key IDs are insecure.

#### Script

To retrieve them from Ubuntu's keyserver, add them to the local keyring, and inspect them, run:

```sh
ubuntu_key_ids=(
    '0x46181433FBB75451'  # Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>
    '0xD94AA3F0EFE21092'  # Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>
)
for key_id in "${ubuntu_key_ids[@]}"; do
    gpg --keyid-format long --keyserver 'hkp://keyserver.ubuntu.com' --recv-keys "${key_id}"
done

for key_id in "${ubuntu_key_ids[@]}"; do
    gpg --keyid-format long --list-keys --with-fingerprint "${key_id}"
done
```

```text
pub   dsa1024/46181433FBB75451 2004-12-30 [SC]
      Key fingerprint = C598 6B4F 1257 FFA8 6632  CBA7 4618 1433 FBB7 5451
uid                 [ unknown] Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>

pub   rsa4096/D94AA3F0EFE21092 2012-05-11 [SC]
      Key fingerprint = 8439 38DF 228D 22F7 B374  2BC0 D94A A3F0 EFE2 1092
uid                 [  full  ] Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>

```

## Packages

### How to update packages for unsupported Ubuntu versions

Example: in 2025, a computer running Ubuntu 21.04 Hirsute Hippo,
which is not LTS and reached EOL years ago.

This means the official repositories for that release have been removed from the main Ubuntu
servers, leading to errors when attempting to run `sudo apt update`.
However, it is still possible to access and install _cached packages_ from the official archives.

Solution for accessing packages for an EOL Ubuntu version:
modify your system's software sources to point to the `old-releases.ubuntu.com` server
(it hosts the final state of the repositories for unsupported Ubuntu releases).

WARNING: if the APT repositories reference country-specific mirrors (e.g. `cl.archive.ubuntu.com`),
you have to follow the instructions below but replacing the mirror domains with the
non-country-specific ones (e.g. `archive.ubuntu.com` instead of `cl.archive.ubuntu.com`).

Technically:

- create a backup of your current sources list:
  ```bash
  sudo cp -p /etc/apt/sources.list /etc/apt/sources.list.bak
  ```
- edit `/etc/apt/sources.list`
- replace all occurrences of `(extras|archive|security).ubuntu.com`
  with `old-releases.ubuntu.com`
- `sudo apt update`
