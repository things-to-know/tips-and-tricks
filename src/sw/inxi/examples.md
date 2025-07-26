# Software / Inxi / Examples

## Example usage

```bash
sudo inxi --full
```

```text
System:
  Host: tp-x1-cg11-1 Kernel: 6.8.0-64-generic x86_64 bits: 64
    Desktop: GNOME 42.9 Distro: Ubuntu 22.04.5 LTS (Jammy Jellyfish)
Machine:
  Type: Laptop System: LENOVO product: {redacted}
    v: ThinkPad X1 Carbon Gen 11 serial: {redacted}
  Mobo: LENOVO model: {redacted} v: {redacted} WIN serial: {redacted}
    UEFI: LENOVO v: N3XET50W (1.25 ) date: 01/25/2024
Battery:
  ID-1: BAT0 charge: 39.7 Wh (80.9%) condition: 49.1/57.0 Wh (86.1%)
CPU:
  Info: 14-core (6-mt/8-st) model: 13th Gen Intel Core i7-1370P bits: 64
    type: MST AMCP cache: L2: 11.5 MiB
  Speed (MHz): avg: 516 min/max: 400/5000:5200:3900 cores: 1: 652 2: 400
    3: 400 4: 400 5: 400 6: 400 7: 717 8: 729 9: 552 10: 400 11: 753 12: 516
    13: 400 14: 777 15: 400 16: 745 17: 496 18: 400 19: 400 20: 400
Graphics:
  Device-1: Intel driver: i915 v: kernel
  Device-2: Acer Integrated RGB Camera type: USB driver: uvcvideo
  Display: server: X.Org v: 1.22.1.1 driver: gpu: i915 note:  X driver n/a
    resolution: 2560x1440~60Hz
  OpenGL: renderer: Mesa Intel Graphics (RPL-P)
    v: 4.6 Mesa 23.2.1-1ubuntu3.1~22.04.3
Audio:
  Device-1: Intel driver: sof-audio-pci-intel-tgl
  Sound Server-1: ALSA v: k6.8.0-64-generic running: yes
  Sound Server-2: PulseAudio v: 15.99.1 running: yes
  Sound Server-3: PipeWire v: 0.3.48 running: yes
Network:
  Device-1: Intel driver: iwlwifi
  IF: wlp0s20f3 state: up mac: 4c:5f:70:45:95:7a
Bluetooth:
  Device-1: Intel type: USB driver: btusb
  Report: hciconfig ID: hci0 state: up address: 4C:5F:70:45:95:7E
Drives:
  Local Storage: total: 953.87 GiB used: 213.78 GiB (22.4%)
  ID-1: /dev/nvme0n1 vendor: KIOXIA model: N/A size: 953.87 GiB
Partition:
  ID-1: / size: 913.75 GiB used: 211.74 GiB (23.2%) fs: ext4 dev: /dev/dm-1
  ID-2: /boot size: 1.61 GiB used: 521.8 MiB (31.7%) fs: ext4
    dev: /dev/nvme0n1p2
  ID-3: /boot/efi size: 511 MiB used: 6.1 MiB (1.2%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: partition size: 1.91 GiB used: 1.52 GiB (80.0%)
    dev: /dev/dm-2
Sensors:
  System Temperatures: cpu: 45.0 C mobo: N/A
  Fan Speeds (RPM): fan-1: 0 fan-2: 0
Info:
  Processes: 509 Uptime: 7d 17h 19m Memory: 31 GiB used: 17.62 GiB (56.9%)
  Shell: Sudo inxi: 3.3.13
```
