#!/usr/bin/bash

dir=$HOME/.dmenu
launcher="rofi -dmenu -i -columns 3"

opts=$(ls $dir)
choice=$(echo "$opts" | awk '{print $1}'| $launcher -p 'Scripts')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice

path=$dir/$choice

myedit $path
