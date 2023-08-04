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

function run_thunderbird {
  if ! flatpak ps | grep org.mozilla.Thunderbird;
  then
    flatpak run --command=thunderbird org.mozilla.Thunderbird &
  fi
}

function run_app {
  if ! pgrep $1;
  then
    ~/apps/$@&
  fi
}

run picom -b --config $HOME/.config/picom/picom.conf
run sxhkd
run ibus-daemon -drxR

run_thunderbird
run_flatpak com.nextcloud.desktopclient.nextcloud
run_flatpak org.signal.Signal

xmodmap ~/.xmodmap

run_app Logseq

run xscreensaver -no-splash
