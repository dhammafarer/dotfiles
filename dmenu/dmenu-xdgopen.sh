#!/usr/bin/bash

dir=$1
prompt=$2

opts=$(ls $1)

# Get the file choice
choice=$(echo "$opts" | awk -F '.' '{print $1}'| mydmenu -i -sb "#5294e2" -p "$prompt")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
filename=$(echo "$opts" | awk -F '.' -v re="$choice" '$1 == re {print $0}')

xdg-open $dir/$filename
