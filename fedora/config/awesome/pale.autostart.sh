#!/bin/bash

function run {
  if ! pgrep $1;
  then
    $@&
  fi
}

function run_flatpak {
  if ! flatpak ps | grep $1;
  then
    flatpak run $@&
  fi
}

function run_app {
  if ! pgrep $1;
  then
    ~/apps/$@&
  fi
}

export SXHKDRC="$HOME/.config/sxhkd/dmenu.sxhkdrc $HOME/.config/sxhkd/sxhkdrc"

run picom -b --config $HOME/.config/picom/picom.conf
run sxhkd -c $SXHKDRC
run ibus-daemon -drxR
run unclutter --timeout 1 --start-hidden --ignore-scrolling

run_flatpak com.nextcloud.desktopclient.nextcloud
run_flatpak org.signal.Signal

xmodmap ~/.xmodmap

run xscreensaver -no-splash
