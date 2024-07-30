{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nodejs_22
    neovim
    nodePackages.prettier
    bundix
    universal-ctags
    tmux
    starship
    gitui
  ];

  imports = [
    ./starship.nix
  ];
}
