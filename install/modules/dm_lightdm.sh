#!/usr/bin/bash

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
    sudo apt install -y "$PKG"
done


sudo systemctl enable lightdm
