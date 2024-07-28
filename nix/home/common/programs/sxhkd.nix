{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    sxhkd
  ];

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + BackSpace" = "kitty";
      "super + 0" = "google-chrome-stable";
      "super + 1" = "rofi -show calc -modi calc -no-show-match -no-sort";
      "super + 2" = "firefox";
      "super + 3" = "rofi-pass --root ~/.password-store 2> /tmp/rofi-pass.log";
      "super + Delete" = "~/.dmenu/quit";
      "super + equal" = "virt-manager";
      "super + shift + Escape" = "playerctl -a pause; xscreensaver-command -l";
      "super + control + Escape" = "xscreensaver-command -a";
      "XF86Tools; p" = "~/.dmenu/process";
      "XF86Tools; x" = "~/.dmenu/xrandr";
      "XF86MonBrightnessUp" = "light -A 5";
      "XF86MonBrightnessDown" = "light -U 5";
      "{XF86AudioPlay,XF86AudioPause}" = "playerctl -i cmus play-pause";
      "{button7,button6}" = "pactl set-sink-volume @DEFAULT_SINK@ {-,+}5%";
      "{XF86AudioLowerVolume,XF86AudioRaiseVolume}" = "pactl set-sink-volume @DEFAULT_SINK@ {-,+}5%";
      "control + XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ 50%; notify-send -t 800 'Master Vol:' 50%";
      "control + XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ 65%; notify-send -t 800 'Master Vol:' 65%";
      "shift + XF86AudioLowerVolume" = "cmus-remote -v -5%";
      "shift + XF86AudioRaiseVolume" = "cmus-remote -v +5%";
      "shift + control + XF86AudioLowerVolume" = "cmus-remote -v 50%; notify-send -t 800 'Cmus Vol:' 50%";
      "shift + control + XF86AudioRaiseVolume" = "cmus-remote -v 75%; notify-send -t 800 'Cmus Vol:' 75%";
      "Print" = "maim --select | xclip -selection clipboard -target image/png";
      "XF86Search" = "rofi -show window";
    };
  };
}
