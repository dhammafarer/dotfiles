{ config, pkgs, ... }:

{
  home.file.".dmenu/quit".source = ../../../../fedora/dmenu/dmenu_quit.sh;
  home.file.".dmenu/process".source = ../../../../fedora/dmenu/dmenu_process.sh;
  home.file.".dmenu/xrandr".source = ../../../../fedora/dmenu/dmenu_xrandr.sh;
  home.file.".dmenu/mindmaps".source = ../../../../fedora/dmenu/dmenu_mindmaps.sh
}
