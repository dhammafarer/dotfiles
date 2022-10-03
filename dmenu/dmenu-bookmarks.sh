#!/bin/bash

conf=/home/pawel/.config/gtk-3.0/bookmarks

#[[ ! -e "$conf" ]] && echo "ERROR: $conf does not exist"; exit 1;

opts=$(cat $conf)

# Get the file choice
choice=$(echo "$opts" | awk -F '/' '{print $NF}'| mydmenu -i -sb "#5294e2" -p 'Open bookmark:')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | awk -F '/' -v re="$choice" '$NF == re {print $0}')

xdg-open $path
