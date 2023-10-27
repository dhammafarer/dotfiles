#!/usr/bin/bash

dir=~/.config/sxhkd
opts=$(ls $dir)
 Get the file choice
choice=$(echo "$opts" | awk -F "." '{print $1}'| mydmenu -sb "#6fccc0" -i -b -p 'Keybindings: ')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
filename=$(echo "$opts" | awk -F "." -v re="$choice" '$1 == re {print $0}')

path=$dir/$filename

killall sxhkd
sxhkd -c $path $SXHKDRC
notify-send "sxhkd profile" "$choice"
