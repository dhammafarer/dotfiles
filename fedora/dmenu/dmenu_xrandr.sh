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

launcher='dmenu -i -nb #192330 -nf #D3D7CF -sb #5294e2 -sf #2f343f -fn 11'

ctn_asus=DP-5
ctn_huion=HDMI-0

nuc_tv=HDMI-A-0
nuc_asus=HDMI-A-1
nuc_huion=DisplayPort-0

restart_wm () {
    awesome-client "awesome.restart()"
}

if [[ $(hostname) == "nuc" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_nuc[@]}")" | $launcher -p 'xrandr profile: ')
  case "$choice" in
    asus)
      xrandr --output $nuc_asus --auto --primary \
        --output $nuc_huion --off \
        --output $nuc_tv --off
      restart_wm
    ;;
    huion)
      xrandr --output $nuc_asus  --off \
        --output $nuc_huion --auto --primary \
        --output $nuc_tv --off
      restart_wm
    ;;
    dual)
      xrandr --output $nuc_asus --auto --primary \
        --output $nuc_huion --auto --below $nuc_asus \
        --output $nuc_tv --off
      restart_wm
    ;;
    tv)
      xrandr --output $nuc_asus --off \
        --output $nuc_huion --off \
        --output $nuc_tv --mode 1360x768 --primary
      restart_wm
    ;;
    *)
      exit 1
    ;;
  esac
elif [[ $(hostname) == "ctn" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_ctn[@]}")" | $launcher -p 'xrandr profile: ')
  case "$choice" in
    asus)
      xrandr --output $ctn_asus --auto --primary \
        --output $ctn_huion --off
      restart_wm
    ;;
    huion)
      xrandr --output $ctn_huion --auto --primary \
        --output $ctn_asus --off
      restart_wm
    ;;
    dual)
      xrandr --output $ctn_asus --auto --primary --output \
        $ctn_huion --auto --below DP-5
      restart_wm
    ;;
    *)
      exit 1
    ;;
  esac
else
  notify-send "xrandr unavailable on this host"
  exit 1
fi
