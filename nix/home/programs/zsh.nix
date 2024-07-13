{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = "source ~/.aliases.d/index.zsh";
    sessionVariables = {
      EDITOR = "nvim";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "avit";
    };
  };

  home.file = {
  	"./.aliases.d" = {
		source = ./aliases.d;
		recursive = true;
	}; 	
  };
}
