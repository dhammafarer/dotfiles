#!/usr/bin/bash

launcher="rofi -dmenu -i -config $HOME/dotfiles/config/rofi/row.config.rasi"

poweroff=""
reboot=""
declare -a options=(
"$poweroff"
"$reboot"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo -e "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Restart process: ')
case "$choice" in
	"$reboot")
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Reboot?")

    [[ "$confirm" == "yes" ]] && { systemctl reboot; }
	;;
	"$poweroff")
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Power off?")

    [[ "$confirm" == "yes" ]] && { systemctl poweroff; }
	;;
	*)
		exit 1
	;;
esac
