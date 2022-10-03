#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: FONTS"
echo

# ------------------------------------------------------------------------

PKGS=(
  'fonts-font-awesome'
  'fonts-powerline'
  'fonts-ubuntu'
  'fonts-noto-cjk'
  'fonts-symbola'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done
