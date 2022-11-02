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
    'vlc'
    'nextcloud-desktop'
    'rofi'
    'okular'
    'seahorse'
    'xscreensaver'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done
