#!/bin/bash

declare -a options=(
"sxhkd"
"reboot"
"poweroff"
"picom"
"xmodmap"
"xmonad"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | mydmenu -sb "#da6371" -sf "#2f343f" -p 'Restart process: ')
case "$choice" in
	picom)
	  killall picom
	  picom
	;;
	sxhkd)
		pkill -USR1 -x sxhkd
	;;
	xmonad)
		xmonad --restart
	;;
	xmodmap)
		xmodmap $HOME/.Xmodmap
	;;
	reboot)
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Reboot?")

    [[ "$confirm" == "yes" ]] && { systemctl reboot; }
	;;
	poweroff)
    confirm=$(echo -e "yes\nno" | mydmenu -sb "#da6371" -sf "#2f343f" -p "Power off?")

    [[ "$confirm" == "yes" ]] && { systemctl poweroff; }
	;;
	*)
		exit 1
	;;
esac
