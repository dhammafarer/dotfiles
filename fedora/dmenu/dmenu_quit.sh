#!/usr/bin/bash

launcher='dmenu -b -i -nb #192330 -nf #D3D7CF -sb #da6371 -sf #192330 -fn 11'

declare -a options=(
"poweroff"
"reboot"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Quit: ')
case "$choice" in
	poweroff)
    confirm=$(echo -e "yes\nno" | $launcher -p "Power off?")

    [[ "$confirm" == "yes" ]] && { systemctl poweroff; }
	;;
	reboot)
    confirm=$(echo -e "yes\nno" | $launcher -p "Reboot?")

    [[ "$confirm" == "yes" ]] && { systemctl reboot; }
	;;
	*)
		exit 1
	;;
esac
