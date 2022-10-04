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
    # Get the label
    label=$(mydmenu -p "Label:")

    # Get the url
    url=$(mydmenu -p "URL:")

    # Exit if no label or url
    [[ -z "$label" || -z "$url" ]] && { notify-send "Bookmark Error" "Label or URL are empty."; exit 1; }

    # Get the tags
    tags=$(mydmenu -p "Tags:" | tr " " ":")
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
    tag=$(echo "$opts" | awk '{print $4}'| tr ":" "\n" | sort | uniq | mydmenu -i -sb "#FFA686" -p "Tags:")

    tagged=$(echo "$opts" | awk -v re="$tag" 'match($4, re) {print $2}' | mydmenu -i -sb "#FFA686" -p "$tag:")

    url=$(echo "$opts" | awk -v re="$tagged" '$2 == re {print $3}')

    firefox $url
	;;
	*)
    url=$(echo "$opts" | awk -v re="$choice" '$2 == re {print $3}')

    firefox $url
  ;;
esac

# Extract a path based on the choice
