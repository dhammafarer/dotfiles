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

run picom -b --config $HOME/.config/picom/picom.conf
run sxhkd
run ibus-daemon -drxR

run_flatpak com.nextcloud.desktopclient.nextcloud
run_flatpak org.signal.Signal

xmodmap ~/.xmodmap

run xscreensaver -no-splash
