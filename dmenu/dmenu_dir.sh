#!/usr/bin/bash

conf=$1
prompt=$2
launcher="rofi -dmenu -i"
#launcher="mydmenu -i -sb #5294e2"

#[[ ! -e "$conf" ]] && echo "ERROR: $conf does not exist"; exit 1;

opts=$(cat $conf)

# Get the file choice
choice=$(echo "$opts" | awk -F '/' '{print $NF}'| $launcher -p "$prompt")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | awk -F '/' -v re="$choice" '$NF == re {print $0}')

xdg-open $path
