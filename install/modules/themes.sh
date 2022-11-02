#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: THEMES"
echo

# ------------------------------------------------------------------------

PKGS=(
    'arc-theme'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

