#!/usr/bin/bash

file=$HOME/dotfiles/config/rofi/themes/shared/colors.base.rasi

launcher="rofi -dmenu -i -columns 3"

opts=$(cat $file | sed '/^[\/\*}]/d' | sed '/^$/d')

choice=$(echo "$opts" | awk '{print $1}'| sed 's/://' | $launcher -p "")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a value based on the choice
value=$(echo "$opts" | awk -v re="$choice:" '$1 == re {print $2}' | sed 's/;//')

# execute command with path
sleep 0.1; xdotool type $value
