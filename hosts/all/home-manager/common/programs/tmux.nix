{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../../../config/tmux/tmux.conf;
    keyMode = "vi";
    mouse = true;
    prefix = "M-[";
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.yank
    ];
  };
}
