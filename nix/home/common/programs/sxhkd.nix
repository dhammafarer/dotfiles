{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        sxhkd
    ];

    services.sxhkd = {
        enable = true;
        keybindings = {
            "super + BackSpace" = "xfce4-terminal";
            "super + 2" = "firefox";
            "super + Delete" = "~/dotfiles/fedora/dmenu/dmenu_quit.sh";
        };
    };
}
