#!/usr/bin/env bash

launcher='dmenu -i -nb #1d1f21 -nf #D3D7CF -sb #37ADD4 -sf #192330 -fn 11'

options=$(tmux list-sessions -F '#S')

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Tmux sessions')

[[ -z "$choice" ]] && { exit 1; }

kitty -e tmux a -t $choice
