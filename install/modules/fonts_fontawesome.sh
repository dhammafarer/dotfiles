#!/bin/bash

[[ ! -d ~/.local/share/fonts ]] && mkdir -p ~/.local/share/fonts

cd /tmp

font=fontawesome-free-6.2.0-web

wget https://github.com/FortAwesome/Font-Awesome/releases/download/6.2.0/$font.zip 
unzip $font.zip -d $HOME/.local/share/fonts/$font/
rm $font.zip

fc-cache
