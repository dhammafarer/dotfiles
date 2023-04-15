#!/usr/bin/bash

conf="$HOME/.repos"

#[[ ! -e "$conf" ]] && echo "ERROR: $conf does not exist"; exit 1;

opts=$(cat $conf)

launcher='dmenu -i -nb #192330 -nf #D3D7CF -sb #e96a9d -sf #192330 -fn 11'

# Get the file choice
choice=$(echo "$opts" | awk -F '/' '{print $NF}'| $launcher -p "Open repo:")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | sed 's/file:\/\///'  |awk -F '/' -v re="$choice" '$NF == re {print $0}')

xfce4-terminal -e "distrobox enter dev -e 'gitui'" --default-working-directory=$path
