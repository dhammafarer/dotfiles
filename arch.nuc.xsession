#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#
xrandr --output HDMI-A-0 --auto --primary --output DisplayPort-0 --auto --below HDMI-A-0
xsetwacom --set "Tablet Monitor stylus" MapToOutput "DisplayPort-0"

sxhkd &

setxkbmap -option compose:caps

#export QT_ENABLE_HIGHDPI_SCALING=0
export HUION="huion-setup-nuc"
export FREEPLANE_USE_UNSUPPORTED_JAVA_VERSION=1
gpg-connect-agent updatestartuptty /bye

signal-desktop &
