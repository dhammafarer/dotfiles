#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: XMONAD"
echo

# ------------------------------------------------------------------------

PKGS=(
    'xmonad'
    'libghc-xmonad-'
    'libghc-xmonad-contrib-dev'
    'dmenu'
    'xfce4-terminal'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

