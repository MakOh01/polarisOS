#!/usr/bin/env bash
set -euo pipefail

SUITE="${SUITE:-trixie}"
ARCH="${ARCH:-amd64}"
OUT="Polaris-OS-${SUITE}-${ARCH}.iso"
MIRROR="${MIRROR:-https://deb.debian.org/debian}"
SECURITY_MIRROR="${SECURITY_MIRROR:-https://security.debian.org/debian-security}"

command -v lb >/dev/null || { echo "live-build is required" >&2; exit 1; }

lb clean --purge 2>/dev/null || true

lb config noauto \
  --mode debian \
  --architectures "$ARCH" \
  --distribution "$SUITE" \
  --mirror-bootstrap "$MIRROR" \
  --mirror-chroot "$MIRROR" \
  --mirror-binary "$MIRROR" \
  --mirror-chroot-security "$SECURITY_MIRROR" \
  --mirror-binary-security "$SECURITY_MIRROR" \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer none \
  --bootappend-live "boot=live components username=polaris hostname=polaris quiet splash" \
  --firmware-binary true \
  --firmware-chroot true \
  --iso-application "Polaris OS" \
  --iso-publisher "Polaris OS" \
  --iso-volume "POLARIS" \
  --memtest none

lb build

mv "live-image-${ARCH}.hybrid.iso" "$OUT"
sha256sum "$OUT" > "$OUT.sha256"
echo "Built: $OUT"
