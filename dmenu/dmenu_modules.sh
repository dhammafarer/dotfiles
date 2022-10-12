#!/usr/bin/bash

dir=$1
prompt=$2
launcher="rofi -dmenu -i -columns 3"

opts=$(ls $dir)
choice=$(echo "$opts" | awk '{print $1}'| $launcher -p "$2")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice

path=$dir/$choice

myedit $path
