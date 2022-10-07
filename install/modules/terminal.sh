#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: TERMINAL"
echo

# ------------------------------------------------------------------------

PKGS=(
    'xfce4-terminal'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

