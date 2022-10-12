#!/usr/bin/bash

current=$HOME/finished
previous=$HOME/doing

launcher="rofi -dmenu -i -columns 1 -p Finished"

move() {
    echo -e "$entry" >> $1

    # add timestamp of last useage
    sed -i "/$2/s/[0-9]\+/$(date +%s)/" $1
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
      [[ -z "$label" ]] && { notify-send "Error" "Label is empty."; exit 1; }

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
      action=$(echo -e "Demote\nDelete" | $launcher -mesg "$choice")

      case "$action" in
        "Promote")

          entry=$(cat "$current" | awk -F "\t" -v re="$choice" '$2 == re {print $0}')

          move $next $entry
          delete $entry
          run
        ;;
        "Demote")

          entry=$(cat "$current" | awk -F "\t" -v re="$choice" '$2 == re {print $0}')

          move $previous $entry
          delete $entry
          run
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
