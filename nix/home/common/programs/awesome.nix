{ config, pkgs, ... }:

{
  xsession.windowManager.awesome =
    {
      enable = true;
    };

  home.file."${config.xdg.configHome}/awesome" = {
	source = ../config/awesome;
	recursive = true;
  };
}
