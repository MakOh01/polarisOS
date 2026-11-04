# Polaris OS

A Debian-based Linux distribution with KDE Plasma, Firefox, broad firmware support,
and a graphical Calamares installer.

## Build requirements

Build on a Debian machine/container with:

```bash
sudo apt update
sudo apt install live-build
```

Then:

```bash
cd polaris
sudo ./build.sh
```

The resulting ISO is normally written to:

```text
live-image-amd64.hybrid.iso
```

## What is included

- Debian Stable base (default currently set to `trixie`; override with `SUITE=`)
- KDE Plasma desktop
- Firefox ESR
- NetworkManager
- PipeWire + WirePlumber
- Calamares graphical installer
- Intel and AMD CPU microcode
- Common Wi-Fi, Ethernet and GPU firmware
- Bluetooth and printing support
- UEFI-friendly hybrid ISO booting

## Build another Debian suite

```bash
sudo SUITE=trixie ./build.sh
```

Change `SUITE` only to a Debian release supported by your installed `live-build`.

## Build in GitHub Actions (no Linux machine required)

This repository includes `.github/workflows/build-polaris.yml`. Upload this project to a GitHub repository, then open **Actions → Build Polaris ISO → Run workflow**. When the job finishes, download the `Polaris-OS-amd64` artifact containing the ISO and SHA256 checksum.
