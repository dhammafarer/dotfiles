{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/awesome" = {
	source = ../../../config/awesome;
	recursive = true;
  };

  home.file."${config.xdg.configHome}/awesome/lain" = {
    source = builtins.fetchGit {
      url = "https://github.com/lcpz/lain";
      rev = "88f5a8abd2649b348ffec433a24a263b37f122c0";
    };
  };
}
