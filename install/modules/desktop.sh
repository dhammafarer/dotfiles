#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: DESKTOP"
echo

# ------------------------------------------------------------------------

PKGS=(
  # browsers
    'chromium'
    'firefox-esr'
  # misc
    'hardinfo'
    'kupfer'
    'nextcloud-desktop'
    'okular'
    'seahorse'
    'signal-desktop'
    'xscreensaver'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
