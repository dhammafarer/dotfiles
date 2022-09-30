#!/bin/bash

declare -a options=(
"nvim"
"vim"
"sxhkd"
"xmobar"
"xmonad"
"xmonad-session-rc"
"xmonad-autostart"
"xresources"
"zsh"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | mydmenu -sb "#ffbd7a" -sf "#2f343f" -p 'Edit config file: ')
case "$choice" in
	nvim)
		choice="/home/pawel/Containers/Arch/.config/nvim/init.vim"
	;;
	sxhkd)
		choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	vim)
		choice="$HOME/.vimrc"
	;;
	xmobar)
		choice="$HOME/.xmonad/xmobar.hs"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	xmonad-session-rc)
		choice="$HOME/.xmonad/xmonad-session-rc"
	;;
	xmonad-autostart)
		choice="$HOME/.xmonad/xmonad-autostart"
	;;
	xresources)
		choice="$HOME/.Xresources"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac

# execute command with choice
xfce4-terminal -e "distrobox enter arch -e 'nvim $choice'" -T "nvim $choice"
