#!/usr/bin/bash

file=~/.dotfiles
#launcher='dmenu -i -nb #192330 -nf #D3D7CF -sb #5294e2 -sf #192330 -fn 11'
launcher="rofi -dmenu -i"

opts=$(cat $file)
# Get the file choice
choice=$(echo "$opts" | awk '{print $1}'| $launcher -p 'Dotfiles')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | awk -v re="$choice" '$1 == re {print $2}')

# execute command with path
#xfce4-terminal -e "distrobox enter dev -e 'nvim $path'" -T "nvim $path"

term=xfce4-terminal
box=dev
tag=dot
idx=10

awesome-client "require('awful.screen').focused().tags[$idx]:view_only()"
awesome-client "require('awful.spawn').spawn('$term -e \"distrobox enter $box -e \'nvim $path\'\" -T \"Edit: $path\"', { tag = '$idx' })"
