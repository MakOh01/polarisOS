#!/usr/bin/env bash
set -euo pipefail

SUITE="${SUITE:-trixie}"
ARCH="${ARCH:-amd64}"
OUT="Polaris-OS-${SUITE}-${ARCH}.iso"
MIRROR="${MIRROR:-https://deb.debian.org/debian}"

command -v lb >/dev/null || { echo "live-build is required" >&2; exit 1; }

lb clean --purge 2>/dev/null || true

# Ubuntu's live-build package still uses the legacy "<suite>/updates" security
# suite format for Debian. Disable the separate security suite for the initial
# ISO build; the normal Debian mirror still provides the selected Trixie release.
lb config noauto \
  --mode debian \
  --architectures "$ARCH" \
  --distribution "$SUITE" \
  --mirror-bootstrap "$MIRROR" \
  --mirror-chroot "$MIRROR" \
  --mirror-binary "$MIRROR" \
  --security false \
  --linux-packages none \
  --initsystem systemd \
  --binary-images iso-hybrid \
  --archive-areas "main contrib non-free non-free-firmware" \
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
