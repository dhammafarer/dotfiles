#!/usr/bin/env bash

launcher="rofi -dmenu -i"

options=$(sesh list --json | jq -r '.[] | .Name + "," + .Src' | column -s"," -t) 

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Tmux sessions')

[[ -z "$choice" ]] && { exit 1; }

session_name=$(echo "$choice" | cut -d' ' -f1)

kitty -T $session_name -e sesh connect $session_name
