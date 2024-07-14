{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
    source ~/.aliases.d/index.zsh
    if [[ -z $SSH_CONNECTION ]]; then
      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    fi
    '';

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
      plugins = [ "git" "fasd" ];
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
