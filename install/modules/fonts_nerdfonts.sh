#!/usr/bin/bash

sudo mkdir ~/.local/share/fonts

cd /tmp
fonts=(
"FiraCode"
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/$font.zip
    sudo unzip $font.zip -d $HOME/.local/share/fonts/$font/
    rm $font.zip
done
fc-cache
