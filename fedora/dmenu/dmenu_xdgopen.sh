#!/usr/bin/bash

dir=$1
prompt=$2
launcher="rofi -dmenu -i"
#launcher="mydmenu -i -sb #5294e2"

opts=$(ls -t $1)

# Get the file choice
choice=$(echo "$opts" | awk -F '.' '{print $1}'| $launcher -p "$prompt")

# Extract a path based on the choice
filename=$(echo "$opts" | awk -F '.' -v re="$choice" '$1 == re {print $0}')

if [[ "$filename" ]]; then
  /var/home/pl/.local/bin/freeplane $dir/$filename
fi

