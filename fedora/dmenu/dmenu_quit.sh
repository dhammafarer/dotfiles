#!/usr/bin/env bash

launcher='dmenu -i -nb #1d1f21 -nf #D3D7CF -sb #cc6666 -sf #1d1f21 -fn 11'

declare -a options=(
"suspend"
"poweroff"
"reboot"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Quit: ')
case "$choice" in
	suspend)
    confirm=$(echo -e "yes\nno" | $launcher -p "Suspend?")

    [[ "$confirm" == "yes" ]] && { systemctl suspend; }
	;;
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
