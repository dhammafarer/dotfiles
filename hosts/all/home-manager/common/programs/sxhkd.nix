{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    sxhkd
  ];

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + BackSpace" = "kitty";
      # "super + 0" = "google-chrome-stable";
      "super + 0" = "flatpak run com.google.Chrome";
      "super + 1" = "rofi -show calc -modi calc -no-show-match -no-sort";
      "super + 2" = "~/.nix-profile/bin/firefox";
      "super + 3" = "rofi-pass --root ~/.password-store 2> /tmp/rofi-pass.log";
      "super + Delete" = "~/.dmenu/quit";
      "super + equal" = "virt-manager";
      "super + shift + Escape" = "playerctl -a pause; xscreensaver-command -l";
      "super + control + Escape" = "xscreensaver-command -a";
      "XF86AudioMute" = "~/dotfiles/arch/bin/cplay";
      "{XF86MonBrightnessUp,XF86MonBrightnessDown}" = "light -{A,U} 2";
      "{XF86AudioPlay,XF86AudioPause}" = "playerctl -i cmus play-pause";
      "{button7,button6}" = "pactl set-sink-volume @DEFAULT_SINK@ {-,+}5%";
      "shift + {button7,button6}" = "light -{U,A} 1";
      "{XF86AudioLowerVolume,XF86AudioRaiseVolume}" = "pactl set-sink-volume @DEFAULT_SINK@ {-,+}5%";
      "control + XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ 50%; notify-send -t 800 'Master Vol:' 50%";
      "control + XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ 65%; notify-send -t 800 'Master Vol:' 65%";
      "shift + XF86AudioLowerVolume" = "cmus-remote -v -5%";
      "shift + XF86AudioRaiseVolume" = "cmus-remote -v +5%";
      "shift + control + XF86AudioLowerVolume" = "cmus-remote -v 50%; notify-send -t 800 'Cmus Vol:' 50%";
      "shift + control + XF86AudioRaiseVolume" = "cmus-remote -v 75%; notify-send -t 800 'Cmus Vol:' 75%";
      "Print" = "maim --select | xclip -selection clipboard -target image/png";
      # "XF86Favorites" = "rofi -show window";
      # "XF86Calculator" = "rofi -show window";
      "XF86HomePage; p" = "~/.dmenu/process";
      "XF86HomePage; x" = "~/.dmenu/xrandr";
      "XF86HomePage; n" = "~/.dmenu/run";
      "XF86Search" = "rofi -show window";
      #"XF86Explorer" = "rofi -show window";
      # "XF86Tools" = "~/dotfiles/arch/bin/hass_state toggle light.kitchen_ceiling";
      # "XF86Launch5" = "~/dotfiles/arch/bin/hass state toggle light.desk";
      # "XF86Launch6" = "~/dotfiles/arch/bin/hass state toggle light.salon";
      "XF86Launch7; g" = "/bin/bash -c 'sleep 0.1 && ssh-add -L | xclip -selection clipboard; xdotool key Control_L+Shift+v'";
      "XF86Launch7; b" = "/bin/bash -c 'sleep 0.1 && xdotool type \"[ci skip] \"'";
      "XF86Launch8" = "~/.dmenu/hass";
      "XF86Launch9" = "~/.dmenu/audio-sinks";
    };
  };
}
# /bin/bash -c "sleep 0.1 && echo site:reddit.com | xclip -selection clipboard; xdotool key Control_L+Shift+v"
