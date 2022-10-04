#!/usr/bin/bash

# File to source
$sb="#FFA686"
conf=$1

[[ ! -e "$conf" ]] && touch $1;

opts=$(cat $conf)

# Get the file choice
choice=$(echo "$opts" | sort -k 1 -nr | awk '{print $2}'| mydmenu -i -sb "#FFA686" -p "Bookmarks:")

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

case "$choice" in
	"+")
    label=$(mydmenu -p "Label:")
    url=$(mydmenu -p "URL:")

    [[ -z "$label" || -z "$url" ]] && { notify-send "Bookmark Error" "Label or URL are empty."; exit 1; }

    echo -e "$(date +%s)\t$label\t\t$url" >> $conf

    notify-send "Added bookmark" "Label: $label\nURL: $url"

    exit 0;
	;;
	".e")
	  myedit $conf
	;;
	*)
    url=$(echo "$opts" | awk -v re="$choice" '$2 == re {print $3}')

    firefox $url
	;;
esac

# Extract a path based on the choice
