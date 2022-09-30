#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.xmonad/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

#cursor active at boot
xsetroot -cursor_name left_ptr &

#starting utility applications at boot time
run volumeicon &
run udiskie -a &

run picom --config $HOME/.config/picom/picom.conf &
#picom -CGb &

run volnoti -t 1 &
run kupfer --no-splash &
#run xscreensaver -no-splash &
run nextcloud &
run goldendict &
#ibus-daemon -drx &
run fcitx5 &
feh --bg-fill $HOME/.background-image &

run stalonetray -c ~/.xmonad/stalonetrayrc --icon-size=20 --kludges=force_icons_size &
