#!/usr/bin/bash

file=$1
launcher="rofi -dmenu -i"
cmd="mpv --input-ipc-server=/tmp/mpvsocket --title='radio-mpv'"

run() {
  notify-send  "Radio Stream" "$choice"
  pkill -f radio-mpv
  $cmd $1
}

opts=$(cat $file)

choice=$(echo -e "$opts" | awk -F "," '{print $1}' | $launcher -p "Radio")

url=$(echo "$opts" | awk -F "," -v re="$choice" '$1 == re {print $2}')

run $url
