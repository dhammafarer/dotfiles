#!/usr/bin/bash

launcher="rofi -dmenu -i"


dir=~/.config/sxhkd
opts=$(ls $dir)
 Get the file choice
choice=$(echo "$opts" | awk '{print $1}'| $launcher -p 'Keymaps')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

path=$dir/$choice

killall sxhkd
sxhkd -c $path $SXHKDRC
