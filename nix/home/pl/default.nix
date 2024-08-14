{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
  	../common/programs/gh.nix
  	../common/programs/git.nix
  	../common/programs/gtk.nix
  	../common/programs/rofi.nix
  	../common/programs/sxhkd.nix
  	../common/programs/zsh.nix
    ../common/programs/tmux.nix
    ../common/programs/dmenu.nix
    ./kitty.nix
    ./neovim.nix
    ./packages-ygt.nix
    ./packages.nix
    ./starship.nix
    ./awesome.nix
  ];
}
