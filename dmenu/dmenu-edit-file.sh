#!/bin/bash

declare -a options=(
"aliases              $HOME/Containers/Arch/.aliases"
"git                  $HOME/.gitconfig"
"nvim                 $HOME/Containers/Arch/.config/nvim/init.vim"
"picom                $HOME/.config/picom/picom.conf"
"sxhkd                $HOME/.config/sxhkd/sxhkdrc"
"sxhkd-blender        $HOME/.config/sxhkd/blender.sxhkdrc"
"sxhkd-houdini        $HOME/.config/sxhkd/houdini.sxhkdrc"
"xbindkeys            $HOME/.xbindkeysrc"
"xmobar               $HOME/.xmonad/xmobar.hs"
"xmodmap              $HOME/.Xmodmap"
"xmonad               $HOME/.xmonad/xmonad.hs"
"xmonad-autostart     $HOME/.xmonad/autostart.sh"
"xmonad-session-rc    $HOME/.xmonad/xmonad-session-rc"
"xresources           $HOME/.Xresources"
"xsession             $HOME/.xsession"
)

# Join the array with line breaks
opts=$(printf '%s\n' "${options[@]}")

# Get the file choice
choice=$(echo "$opts" | awk '{print $1}'| mydmenu -sb "#ffb05f" -p 'Edit config file: ')

# If selection is empty, exit
[[ -z "$choice" ]] && { exit 1; }

# Extract a path based on the choice
path=$(echo "$opts" | awk -v re="$choice" '$1 == re {print $2}' | envsubst)

# execute command with path
xfce4-terminal -e "distrobox enter arch -e 'nvim $path'" -T "nvim $path"
