#!/usr/bin/bash

current=$HOME/inbox
next=$HOME/doing

launcher="rofi -dmenu -i -columns 1 -p Inbox"

move() {
    echo -e "$entry" >> $next

    # add timestamp of last useage
    sed -i "/$2/s/[0-9]\+/$(date +%s)/" $1
    $HOME/.dmenu/dmenu_doing.sh
}

delete() {
    sed -i "/$1/d" $current
}

run() {
  choice=$(cat "$current" | awk -F "\t" '{print $2}'| $launcher)

  # If selection is empty, exit
  [[ -z "$choice" ]] && { exit 1; }

  case "$choice" in
    "+")
      label=$($launcher -p "Label")
       #Exit if no label or url
      [[ -z "$label" ]] && { notify-send -u critical "Error" "Label is empty."; exit 1; }

       #append to the conf file
      date=$(date +%s)

      echo -e "$date\t$label\t$date" >> $current

      #notify of success
      notify-send "Added bookmark" "Label: $label"
      run
    ;;
    ".e")
      myedit $current
    ;;
    *)
      action=$(echo -e "Move to 'In Progress'\nDelete" | $launcher -mesg "$choice")

      case "$action" in
        "Move to 'In Progress'")

          entry=$(cat "$current" | awk -F "\t" -v re="$choice" '$2 == re {print $0}')

          move $next $entry
          delete $entry
        ;;
        "Delete")
          entry=$(cat "$current" | awk -F "\t" -v re="$choice" '$2 == re {print $0}')
          delete $entry
          run
        ;;
        *)
          run
        ;;
      esac
    ;;
  esac
}

run
