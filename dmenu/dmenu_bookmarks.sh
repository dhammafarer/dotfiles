#!/usr/bin/bash

run_bookmark() {
    # add timestamp of last useage
    sed -i "/$2/s/[0-9]\+/$(date +%s)/" $conf

    xdg-open $1
}

# File to source
conf=$1
opts=$(cat $conf)

#launcher="mydmenu -i -sb #ef8354"
launcher="rofi -dmenu -i"

[[ ! -e "$conf" ]] && { notify-send -u critical "Bookmark Error" "No bookmark file"; exit 1; }

# Get the file choice
get_choice() {
  choice=$(echo -e "$opts" \
    | sort -k 1 -nr \
    | awk -F "\t" -v re=$1 'match($4,re) {print $6"\t"$2}' \
    | sed 's/null/ /g' \
    | $launcher -p "")

  echo "$choice"
}

choice=$(get_choice)

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

match_choice () {
  case "$choice" in
    "+")
      label=$($launcher -p "Label")
      url=$($launcher  -p "URL")

      # Exit if no label or url
      [[ -z "$label" || -z "$url" ]] && { notify-send -u critical "Bookmark Error" "Label or URL are empty."; exit 1; }

      # Get the tags
      tags=$($launcher -p "Tags:" | tr " " ",")
      [[ -z "$tags" ]] && tags="none"

      case $(echo "$tags" | awk '{print $1}') in
        dev)
          icon="\uf121"
        ;;
        reddit)
          icon="\uf281"
        ;;
        youtube)
          icon="\uf167"
        ;;
        facebook)
          icon="\uf09a"
        ;;
        football)
          icon="\uf1e3"
        ;;
        music)
          icon="\uf04b"
        ;;
        design)
          icon="\uf53f"
        ;;
        github)
          icon="\uf09b"
        ;;
        shopping)
          icon="\uf07a"
        ;;
        email)
          icon="\uf0e0"
        ;;
        tool)
          icon="\uf7d9"
        ;;
        *)
          icon="null"
        ;;
      esac

      # append to the conf file
      date=$(date +%s)
      echo -e "$date\t$label\t$url\t$tags\t$date\t$icon" >> $conf

      # notify of success
      notify-send "Added bookmark" "Label: $label\nURL: $url"

      exit 0;
    ;;
    ".e")
      myedit $conf
    ;;

    "#")
      tag=$(echo "$opts" | awk -F "\t" '{print $4}'| tr "," "\n" | sort | uniq | $launcher -p "#")

      # If selection is empty, exit
      [[ -z "$tag" ]] && { exit 1; }

      #choice=$(echo -e "$opts" | awk -v re="$tag" 'match($4, re) {print $6"\t"$2}' | sed 's/%20/ /g' | $launcher -p "$tag" | sed 's/ /%20/g')
      get_choice $tag

      match_choice $choice
    ;;

    *)
      label=$(echo "$choice" | awk -F "\t" '{print $2}')
      url=$(echo "$opts" | awk -F "\t" -v re="$label" '$2 == re {print $3}')

      [[ -z "$url" ]] && { exit 1; }

      run_bookmark $url $label
    ;;
  esac
}

# Extract a path based on the choice
match_choice $choice
