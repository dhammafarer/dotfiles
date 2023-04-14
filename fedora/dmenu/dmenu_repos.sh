#!/usr/bin/bash

conf=$1

#[[ ! -e "$conf" ]] && echo "ERROR: $conf does not exist"; exit 1;

opts=$(cat $conf)

# Get the file choice
choice=$(echo "$opts" | awk -F '/' '{print $NF}'| mydmenu -i -sb "#e96a9d" -p "Open repo:")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | sed 's/file:\/\///'  |awk -F '/' -v re="$choice" '$NF == re {print $0}')

xfce4-terminal -e "distrobox enter arch -e 'gitui'" --default-working-directory=$path
