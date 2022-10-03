#!/bin/bash

echo
echo "INSTALLING"
echo "MODULE: YUBIKEY"
echo

# ------------------------------------------------------------------------

PKGS=(
    'gnupg2'
    'gnupg-agent'
    'dirmngr'
    'cryptsetup'
    'scdaemon'
    'pcscd'
    'secure-delete'
    'yubikey-personalization'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

