#!/usr/bin/bash

launcher="rofi -dmenu -i -config $HOME/dotfiles/config/rofi/row.config.rasi"

poweroff=""
reboot=""
log_out=""

declare -a options=(
"$poweroff"
"$reboot"
"$log_out"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo -e "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Restart process: ')
case "$choice" in
	"$reboot")
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Confirm")

    [[ "$confirm" == "yes" ]] && { systemctl reboot; }
	;;
	"$poweroff")
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Conifrm")

    [[ "$confirm" == "yes" ]] && { systemctl poweroff; }
	;;
	"$log_out")
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Confirm")

	  sleep 0.1; xdotool key super+shift+m
	;;
	*)
		exit 1
	;;
esac
