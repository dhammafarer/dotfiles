{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/nvim" = {
	source = ../common/config/nvim;
	recursive = true;
  };
}
