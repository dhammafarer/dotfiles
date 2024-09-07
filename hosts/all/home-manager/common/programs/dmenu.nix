{ config, pkgs, ... }:

{
  home.file.".dmenu/hass".source = ../../../scripts/dmenu/dmenu_hass.sh;
  home.file.".dmenu/mindmaps".source = ../../../scripts/dmenu/dmenu_mindmaps.sh;
  home.file.".dmenu/process".source = ../../../scripts/dmenu/dmenu_process.sh;
  home.file.".dmenu/quit".source = ../../../scripts/dmenu/dmenu_quit.sh;
  home.file.".dmenu/run".source = ../../../scripts/dmenu/dmenu_run.sh;
  home.file.".dmenu/xrandr".source = ../../../scripts/dmenu/dmenu_xrandr.sh;
}
