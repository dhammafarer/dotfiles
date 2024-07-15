{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        sxhkd
    ];

    services.sxhkd = {
        enable = true;
        keybindings = {
            "super + BackSpace" = "xfce4-terminal";
        };
    };
}
