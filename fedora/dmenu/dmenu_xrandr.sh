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

declare -a options_deck=(
"external"
"builtin"
"dual"
"presentation"
)

declare -a options_pale=(
"external"
"builtin"
"dual"
"presentation"
)

launcher='dmenu -i -nb #192330 -nf #D3D7CF -sb #5294e2 -sf #2f343f -fn 11'

ctn_asus=DP-5
ctn_huion=HDMI-0

deck_builtin="eDP --rotate right"
deck_external="DisplayPort-0"

pale_builtin=eDP-1
pale_external=DP-5

nuc_tv=HDMI-A-0
nuc_asus=HDMI-A-4
nuc_huion=DisplayPort-0

restart_wm () {
    awesome-client "awesome.restart()"
}

if [[ $(hostname -s) == "nuc" ]];
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
elif [[ $(hostname -s) == "ctn" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_ctn[@]}")" | $launcher -p 'xrandr profile: ')
  case "$choice" in
    asus)
      xrandr --output $ctn_asus --auto --primary
      xrandr --output $ctn_huion --off
      restart_wm
    ;;
    huion)
      xrandr --output $ctn_huion --auto --primary
      xrandr --output $ctn_asus --off
      restart_wm
    ;;
    dual)
      xrandr --output $ctn_asus --auto --primary
      xrandr --output $ctn_huion --auto --below $ctn_asus
      restart_wm
    ;;
    *)
      exit 1
    ;;
  esac
elif [[ $(hostname -s) == "deck" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_deck[@]}")" | $launcher -p 'xrandr profile: ')
  case "$choice" in
    external)
      xrandr --output $deck_external --auto --primary
      xrandr --output $deck_builtin --off
      restart_wm
    ;;
    builtin)
      xrandr --output $deck_builtin --auto --primary
      xrandr --output $deck_external --off
      restart_wm
    ;;
    dual)
      xrandr --output $deck_external --auto --primary
      xrandr --output $deck_builtin --auto --below $deck_external
      restart_wm
    ;;
    presentation)
      xrandr --output $deck_builtin --auto --primary
      xrandr --output $deck_external --auto --above $deck_builtin --rotate normal
      restart_wm
    ;;
    *)
      exit 1
    ;;
  esac
elif [[ $(hostname -s) == "pale" ]];
then
  choice=$(echo "$(printf '%s\n' "${options_pale[@]}")" | $launcher -p 'xrandr profile: ')
  case "$choice" in
    dual)
      xrandr --output $pale_external --auto --primary
      xrandr --output $pale_builtin --auto --below $pale_external
      restart_wm
    ;;
    builtin)
      xrandr --output $pale_builtin --auto --primary
      xrandr --output $pale_external --off
      restart_wm
    ;;
    external)
      xrandr --output $pale_external --auto --primary
      xrandr --output $pale_builtin --off
      restart_wm
    ;;
    presentation)
      xrandr --output $pale_builtin --auto --primary
      xrandr --output $pale_external --auto --above $pale_builtin
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
