#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: LIGHTDM"
echo

# ------------------------------------------------------------------------

PKGS=(
    'lightdm'
    'lightdm-gtk-greeter'
    'lightdm-gtk-greeter-settings'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done


sudo systemctl enable lightdm
