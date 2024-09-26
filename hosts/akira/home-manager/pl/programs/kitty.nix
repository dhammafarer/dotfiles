{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/kitty" = {
	source = ../../../../all/config/kitty;
	recursive = true;
  };
}
