#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: XMONAD"
echo

# ------------------------------------------------------------------------

PKGS=(
    'xmonad'
    'xmobar'
    'stalonetray'
    'libghc-xmonad-'
    'libghc-xmonad-contrib-dev'
    'feh'
    'dmenu'
    'rofi'
    'picom'
    'sxhkd'
    'xfce4-terminal'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

ln -fs ~/dotfiles/install/files/background-image ~/.background-image
