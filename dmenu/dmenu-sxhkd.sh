#!/bin/bash

declare -a options=(
"base"
"blender"
"houdini"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | mydmenu -sb "#6fccc0" -sf "#2f343f" -p 'sxhkd config: ')
case "$choice" in
	base)
		killall sxhkd
		sxhkd -c $HOME/.config/sxhkd/sxhkdrc
	;;
	houdini)
		killall sxhkd
		sxhkd -c $HOME/.config/sxhkd/houdini.sxhkdrc $HOME/.config/sxhkd/sxhkdrc
	;;
	blender)
		killall sxhkd
		sxhkd -c $HOME/.config/sxhkd/blender.sxhkdrc $HOME/.config/sxhkd/sxhkdrc
	;;
	*)
		exit 1
	;;
esac
