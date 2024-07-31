{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./packages-ygt.nix
    ./starship.nix
    ./neovim.nix
  	../common/programs/zsh.nix
  	../common/programs/gtk.nix
  	../common/programs/gh.nix
  	../common/programs/git.nix
  	../common/programs/sxhkd.nix
  	../common/programs/rofi.nix
    ../common/programs/tmux.nix
  ];
}
