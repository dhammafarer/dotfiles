{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    cursorTheme.name = "Adwaita";
    cursorTheme.size = 16;
    gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
