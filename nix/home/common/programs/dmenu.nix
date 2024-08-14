{ config, pkgs, ... }:

{
  home.file.".dmenu/quit".source = ../../../../fedora/dmenu/dmenu_quit.sh;
  home.file.".dmenu/process".source = ../../../../fedora/dmenu/dmenu_process.sh;
  home.file.".dmenu/xrandr".source = ../../../../fedora/dmenu/dmenu_xrandr.sh;
  home.file.".dmenu/mindmaps".source = ../../../../fedora/dmenu/dmenu_mindmaps.sh;
  home.file.".dmenu/hass".source = ../../../../fedora/dmenu/dmenu_hass.sh;
  home.file.".dmenu/run".source = ../../../../fedora/dmenu/dmenu_run.sh;
}
