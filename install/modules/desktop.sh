#!/usr/bin/bash

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
    'mpv'
    'nextcloud-desktop'
    'rofi'
    'okular'
    'seahorse'
    'signal-desktop'
    'xscreensaver'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
