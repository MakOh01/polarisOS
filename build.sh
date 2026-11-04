#!/usr/bin/env bash
set -euo pipefail

SUITE="${SUITE:-trixie}"
ARCH="${ARCH:-amd64}"
OUT="Polaris-OS-${SUITE}-${ARCH}.iso"
MIRROR="${MIRROR:-https://deb.debian.org/debian}"

command -v lb >/dev/null || { echo "live-build is required" >&2; exit 1; }

lb clean --purge 2>/dev/null || true

# Use Debian Trixie's own live-build rather than Ubuntu 24.04's legacy 3.0~a57.
# The Trixie version understands the current archive layout and hybrid BIOS/UEFI boot.
lb config noauto \
  --mode debian \
  --architecture "$ARCH" \
  --distribution "$SUITE" \
  --mirror-bootstrap "$MIRROR" \
  --mirror-chroot "$MIRROR" \
  --mirror-binary "$MIRROR" \
  --apt-recommends false \
  --linux-packages none \
  --initsystem systemd \
  --binary-image iso-hybrid \
  --bootloaders "syslinux,grub-efi" \
  --archive-areas "main contrib non-free non-free-firmware" \
  --bootappend-live "boot=live components username=polaris hostname=polaris locales=en_US.UTF-8 keyboard-layouts=us quiet splash" \
  --firmware-binary true \
  --firmware-chroot true \
  --iso-application "Polaris OS" \
  --iso-publisher "Polaris OS" \
  --iso-volume "POLARIS" \
  --memtest none

# GitHub's file API creates hooks as non-executable; mark chroot hooks runnable.
chmod +x config/hooks/normal/*.hook.chroot

lb build

mv "live-image-${ARCH}.hybrid.iso" "$OUT"
sha256sum "$OUT" > "$OUT.sha256"
echo "Built: $OUT"
