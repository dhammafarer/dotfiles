#!/usr/bin/bash

declare -a options_ctn=(
"asus"
"dual"
"huion"
)

declare -a options_nuc=(
"asus"
"dual"
"huion"
"tv"
)

ctn_asus=DP-5
ctn_huion=HDMI-0

nuc_tv=HDMI-A-0
nuc_asus=HDMI-A-1
nuc_huion=DisplayPort-0

if [[ $(hostname) == "debian-nuc" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_nuc[@]}")" | mydmenu -sb "#5294e2" -sf "#2f343f" -p 'xrandr profile: ')
  case "$choice" in
    asus)
      xrandr --output $nuc_asus --auto --primary \
        --output $nuc_huion --off \
        --output $nuc_tv --off
    ;;
    huion)
      xrandr --output $nuc_asus  --off \
        --output $nuc_huion --auto --primary \
        --output $nuc_tv --off
    ;;
    dual)
      xrandr --output $nuc_asus --auto --primary \
        --output $nuc_huion --auto --below $nuc_asus \
        --output $nuc_tv --off
    ;;
    tv)
      xrandr --output $nuc_asus --off \
        --output $nuc_huion --off \
        --output $nuc_tv --mode 1360x768 --primary
    ;;
    *)
      exit 1
    ;;
  esac
elif [[ $(hostname) == "ctn" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_ctn[@]}")" | mydmenu -sb "#5294e2" -sf "#2f343f" -p 'xrandr profile: ')
  case "$choice" in
    asus)
      xrandr --output $ctn_asus --auto --primary \
        --output $ctn_huion --off
    ;;
    huion)
      xrandr --output $ctn_huion --auto --primary \
        --output $ctn_asus --off
    ;;
    dual)
      xrandr --output $ctn_asus --auto --primary --output \
        $ctn_huion --auto --below DP-5
    ;;
    *)
      exit 1
    ;;
  esac
else
  notify-send "xrandr unavailable on this host"
  exit 1
fi
