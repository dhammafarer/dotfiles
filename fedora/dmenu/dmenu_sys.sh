#!/usr/bin/bash

declare -a options=(
"setup-dotfiles"
)

file=~/.dotfiles
#launcher='dmenu -i -nb #192330 -nf #D3D7CF -sb #5294e2 -sf #192330 -fn 11'
launcher="rofi -dmenu -i"

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Run Command: ')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

term=xfce4-terminal
box=dev
idx=11

awesome-client "require('awful.screen').focused().tags[$idx]:view_only()"
notify-send $choice
awesome-client "require('awful.spawn').spawn('$term -e \"distrobox enter $box -e \'sleep 1 && whoami & sleep 1\'\" -T \"Edit: $choice\"')"
