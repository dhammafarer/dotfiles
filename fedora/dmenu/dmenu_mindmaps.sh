#!/usr/bin/bash

dir=$HOME/Nextcloud/Documents/mindmaps
prompt="Mindmaps"
columns=3

launcher="rofi -dmenu -i"

opts=$(ls -t $dir)

# Get the file choice
choice=$(echo "$opts" | awk -F '.' '{print $1}' \
  | $launcher -p "$prompt")

# Extract a path based on the choice
filename=$(echo "$opts" | awk -F '.' -v re="$choice" '$1 == re {print $0}')

if [[ "$filename" ]]; then
  /var/home/pl/.local/bin/freeplane $dir/$filename
fi
