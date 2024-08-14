{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/kitty" = {
	source = ../common/config/kitty;
	recursive = true;
  };
}
