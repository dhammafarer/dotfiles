#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: BASE"
echo

# ------------------------------------------------------------------------

PKGS=(
    'atool'
    'autojump'
    'bat'
    'curl'
    'exa'
    'htop'
    'neofetch'
    'ntfs-3g'
    'ntp'
    'paperkey'
    'pass'
    'podman'
    'ranger'
    'rsync'
    'unrar'
    'usbutils'
    'wget'
    'zip'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

# ------------------------------------------------------------------------

[[-e ~/.local/bin ]] && mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
