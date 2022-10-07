#!/usr/bin/bash

file=$1
launcher="rofi -dmenu -i"
cmd="mpv --input-ipc-server=/tmp/mpvsocket --title='radio-mpv'"

declare -a options=(
"Deep Space One"
"Positively Vibe"
"Defcon"
)

run() {
  notify-send  "Radio Stream" "$choice"
  pkill -f radio-mpv
  $cmd $1
}

choice=$(echo "$(printf '%s\n' "${options[@]}")" | awk -F "," '{print $1}' | $launcher -p "Radio")

case "$choice" in
	  "Deep Space One")
    run http://ice1.somafm.com/deepspaceone-128-mp3
	;;
    "Positively Vibe")
    run https://streaming.positivity.radio/pr/posivibe/icecast.audio
	;;
    "Defcon")
    run https://ice1.somafm.com/defcon-128-mp3
	;;
	*)
		exit 1
	;;
esac
