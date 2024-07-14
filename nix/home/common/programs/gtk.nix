{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    cursorTheme.name = "Adwaita";
    cursorTheme.size = 12;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
