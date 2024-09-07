{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
  	../../../all/home-manager/common/programs/gh.nix
  	../../../all/home-manager/common/programs/git.nix
  	../../../all/home-manager/common/programs/gtk.nix
  	../../../all/home-manager/common/programs/rofi.nix
  	../../../all/home-manager/common/programs/sxhkd.nix
  	../../../all/home-manager/common/programs/zsh.nix
    ../../../all/home-manager/common/programs/tmux.nix
    ../../../all/home-manager/common/programs/dmenu.nix
    ../../../all/home-manager/common/programs/xorg.nix
    ./programs/kitty.nix
    ./programs/neovim.nix
    ./programs/packages.nix
    ./programs/starship.nix
    ./programs/awesome.nix
  ];
}
