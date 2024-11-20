{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/cmus/lib.pl" = {
	source = ../../../config/cmus/lib.pl;
  };
}
