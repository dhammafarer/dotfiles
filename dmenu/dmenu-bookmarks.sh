#!/usr/bin/bash

# File to source
conf=$1

#launcher="mydmenu -i -sb #ef8354"
launcher="$HOME/.local/bin/rofi -dmenu -i"

[[ ! -e "$conf" ]] && touch $1;

opts=$(cat $conf)

# Get the file choice
choice=$(echo "$opts" | sort -k 1 -nr | awk '{print $2}' | sed 's/%20/ /g' | $launcher -p "Bookmarks" | sed 's/ /%20/g')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

case "$choice" in
  "+")
    # Get the label
    label=$($launcher -p "Label" | sed 's/ /%20/g')

    # Get the url
    url=$($launcher  -p "URL")

    # Exit if no label or url
    [[ -z "$label" || -z "$url" ]] && { notify-send -u critical "Bookmark Error" "Label or URL are empty."; exit 1; }

    # Get the tags
    tags=$($launcher -p "Tags:" | tr " " ":")
    [[ -z "$tags" ]] && tags="none"

    # append to the conf file
    echo -e "$(date +%s)\t\t$label\t\t$url\t\t$tags" >> $conf

    # notify of success
    notify-send "Added bookmark" "Label: $label\nURL: $url"

    exit 0;
  ;;
  ".e")
	  myedit $conf
	;;
  "#")
    tag=$(echo "$opts" | awk '{print $4}'| tr ":" "\n" | sort | uniq | $launcher -p "Tags")

    # If selection is empty, exit
    [[ -z "$tag" ]] && { exit 1; }

    tagged=$(echo "$opts" | awk -v re="$tag" 'match($4, re) {print $2}' | sed 's/%20/ /g' | $launcher -p "$tag" | sed 's/ /%20/g')

    url=$(echo "$opts" | awk -v re="$tagged" '$2 == re {print $3}')

    # If selection is empty, exit
    [[ -z "$url" ]] && { exit 1; }

    firefox $url
	;;
	*)
    url=$(echo "$opts" | awk -v re="$choice" '$2 == re {print $3}')

    [[ -z "$url" ]] && { exit 1; }
    firefox $url
  ;;
esac

# Extract a path based on the choice
