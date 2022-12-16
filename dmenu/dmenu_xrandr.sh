#!/usr/bin/bash

declare -a options=(
"ctn:asus"
"ctn:dual"
"ctn:huion"
"nuc:asus"
"nuc:dual"
"nuc:huion"
"nuc:tv"
)

ctn_asus=DP-5
ctn_huion=HDMI-0

nuc_tv=HDMI-A-0
nuc_asus=HDMI-A-1
nuc_huion=DisplayPort-0

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
    xrandr --output $nuc_asus --auto --primary \
      --output $nuc_huion --off \
      --output $nuc_tv --off
	;;
	nuc:huion)
    xrandr --output $nuc_asus  --off \
      --output $nuc_huion --auto --primary \
      --output $nuc_tv --off
	;;
	nuc:dual)
    xrandr --output $nuc_asus --auto --primary \
      --output $nuc_huion --auto --below $nuc_asus \
      --output $nuc_tv --off
	;;
	nuc:tv)
    xrandr --output $nuc_asus --auto --primary \
      --output $nuc_huion --off \
      --output $nuc_tv --auto --right-of $nuc_asus
	;;
	*)
		exit 1
	;;
esac
