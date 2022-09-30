#!/bin/bash

declare -a options=(
"sxhkd"
"xmodmap"
"xmonad"
"reboot"
"shutdown"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | mydmenu -sb "#da6371" -sf "#2f343f" -p 'Restart process: ')
case "$choice" in
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
		systemctl reboot
	;;
	shutdown)
		systemctl poweroff
	;;
	*)
		exit 1
	;;
esac
