{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    cursorTheme.name = "Adwaita";
    cursorTheme.size = 16;
    gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
