{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ../config/tmux/tmux.conf;
    keyMode = "vi";
    mouse = true;
    shortcut = "b";
  };
}
