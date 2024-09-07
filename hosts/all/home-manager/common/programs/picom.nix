{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/picom/picom.conf" = {
	source = ../../../config/picom/picom.conf;
  };
}
