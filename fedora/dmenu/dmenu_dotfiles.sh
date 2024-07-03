#!/usr/bin/bash

dotfiles_dir=~/.dotfiles.d
launcher="rofi -dmenu -i"

opts=$(find $dotfiles_dir/* | xargs cat)
# Get the file choice
choice=$(echo "$opts" | awk '{print $1}'| $launcher -p 'Dotfiles')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | awk -v re="$choice" '$1 == re {print $2}')

term=xfce4-terminal
box=dev
idx=2

awesome-client "require('awful.screen').focused().tags[$idx]:view_only()"
awesome-client "require('awful.spawn').spawn('$term -e \"distrobox enter $box -- nvim -f $path\"')"
