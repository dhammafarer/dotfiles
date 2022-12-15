#!/usr/bin/bash

declare -a options=(
"ctn:asus"
"ctn:dual"
"ctn:huion"
"nuc:asus"
"nuc:dual"
"nuc:huion"
)

ctn_asus=DP-5
ctn_huion=HDMI-0
nuc_asus=HDMI-0
nuc_huion=HDMI-1

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | mydmenu -sb "#da6371" -sf "#2f343f" -p 'Restart process: ')
case "$choice" in
	ctn:asus)
    xrandr --output $ctn_asus --auto --primary --output $ctn_huion --off
	;;
	ctn:huion)
    xrandr --output $ctn_huion --auto --primary --output $ctn_asus --off
	;;
	ctn:dual)
    xrandr --output $ctn_asus --auto --primary --output $ctn_huion --auto --below DP-5
	;;
	nuc:asus)
    xrandr --output $nuc_asus --auto --primary --output $nuc_huion --off
	;;
	nuc:huion)
    xrandr --output $nuc_huion --auto --primary --output $nuc_asus --off
	;;
	nuc:dual)
    xrandr --output $nuc_asus --auto --primary --output $nuc_huion --auto --below DP-5
	;;
	*)
		exit 1
	;;
esac
