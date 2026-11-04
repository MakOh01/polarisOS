# Polaris OS

Polaris OS is a Debian-based Linux distribution built around KDE Plasma. It is designed as a practical desktop and live environment with broad hardware and Wi-Fi support, a graphical installer, and a familiar set of everyday applications.

## What is included

### Desktop and applications

- Debian Stable base (currently `trixie`)
- KDE Plasma desktop with SDDM
- System Settings
- Firefox ESR
- Dolphin file manager
- Konsole terminal
- Kate text editor
- Ark archive manager
- Okular document viewer
- Gwenview image viewer
- VLC media player
- KCalc calculator
- Filelight disk usage viewer
- KDE Partition Manager
- KDE Discover with Flatpak backend

### Networking and Wi-Fi

Polaris includes NetworkManager and a broader wireless stack intended to work across common laptop hardware:

- NetworkManager + Plasma NetworkManager integration
- WPA Supplicant
- IWD
- Wireless regulatory database
- `iw`, `rfkill`, and wireless diagnostic tools
- Intel Wi-Fi firmware
- Realtek Wi-Fi firmware
- Atheros Wi-Fi firmware
- Broadcom Wi-Fi firmware
- MediaTek Wi-Fi firmware
- Ralink Wi-Fi firmware
- Libertas and legacy Intel firmware

This is intended to provide out-of-the-box coverage for a wide range of common laptop wireless adapters, including many ThinkPad models.

### Hardware support

- Linux AMD64 kernel
- Intel and AMD CPU microcode
- Intel audio firmware
- AMD graphics firmware
- Broad non-free and miscellaneous firmware packages
- Bluetooth support
- Printing support
- NTFS and exFAT filesystem support

### System components

- PipeWire + WirePlumber audio
- Calamares graphical installer
- US English locale and dictionaries
- UEFI/BIOS hybrid ISO boot support

## Live environment

The live image creates a `polaris` desktop user and is configured to enter the Plasma session automatically, so booting the ISO should take you directly to the desktop without requiring a username or password.

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

## Build another Debian suite

```bash
sudo SUITE=trixie ./build.sh
```

Only change `SUITE` to a Debian release supported by your installed version of `live-build`.

## Build with GitHub Actions

No Linux machine is required to build Polaris OS.

Push the repository to GitHub and use the included workflow under:

**Actions → Build Polaris ISO**

When the build finishes successfully, download the **Polaris-OS-amd64** artifact. It contains the generated ISO and its SHA256 checksum.
