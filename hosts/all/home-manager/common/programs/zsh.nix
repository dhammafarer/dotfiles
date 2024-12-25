{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
    source ~/.config/zsh/aliases.d/index.zsh
    if [[ -z $SSH_CONNECTION ]]; then
      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    fi

    if [[ "$TERM" != "screen-256color" ]]; then
      tmux attach-session -t "$USER" ||tmux new-session -s "$USER"
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
      plugins = [ "git" "fasd" "pass" "systemd" ];
      theme = "avit";
    };
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
  ];

  home.file."${config.xdg.configHome}/zsh/aliases.d" = {
	source = ../../../config/zsh/aliases.d;
	recursive = true;
  };
}
