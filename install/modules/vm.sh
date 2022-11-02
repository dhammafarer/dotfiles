#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: VM"
echo

# ------------------------------------------------------------------------

PKGS=(
    'qemu-system'
    'libvirt-daemon-system'
    'virt-manager'
    'vagrant'
    'vagrant-libvirt'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done

# ------------------------------------------------------------------------

sudo usermod -aG libvirt pl
