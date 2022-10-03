#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: BASE"
echo

# ------------------------------------------------------------------------

PKGS=(
    'atool'
    'bat'
    'curl'
    'exa'
    'feh'
    'htop'
    'neofetch'
    'ntfs-3g'
    'ntp'
    'paperkey'
    'pass'
    'ranger'
    'rsync'
    'translate-shell'
    'unrar'
    'unzip'
    'usbutils'
    'usbmount'
    'wget'
    'zip'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

