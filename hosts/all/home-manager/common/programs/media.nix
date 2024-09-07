{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    cmus
  ];

  home.file."${config.xdg.configHome}/cmus/lib.pl" = {
    source = ../config/cmus/lib.pl;
  };
}
