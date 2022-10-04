#!/usr/bin/bash

echo
echo "INSTALLING"
echo "MODULE: AUDIO"
echo

# ------------------------------------------------------------------------

PKGS=(
  'pulseaudio'
  'alsa-utils'
  'pavucontrol'
  'volumeicon-alsa'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install -y "$PKG"
done
