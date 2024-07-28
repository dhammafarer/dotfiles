#!/usr/bin/env bash

function run {
  if ! pgrep $1;
  then
    $@&
  fi
}

run picom -b --config $HOME/.config/picom/picom.conf
run sxhkd
# run ibus-daemon -drxR
run unclutter --timeout 1 --start-hidden --ignore-scrolling &
run slack
xmodmap ~/.Xmodmap

run xscreensaver -no-splash
