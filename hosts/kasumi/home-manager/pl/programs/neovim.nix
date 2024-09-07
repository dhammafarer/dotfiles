{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/nvim" = {
	source = ../../../../all/config/nvim;
	recursive = true;
  };
}
