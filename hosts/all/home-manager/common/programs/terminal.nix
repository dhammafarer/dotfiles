{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.xfce4-terminal
  ];

  #home.file."${config.xdg.configHome}/xfce4/terminal" = {
  #  source = ../config/xfce4/terminal;
  #  recursive = true;
  #};
}
