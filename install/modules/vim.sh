#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: VIM"
echo

# ------------------------------------------------------------------------

PKGS=(
    'xorg'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

