{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  imports = [
  	# ../../../all/home-manager/common/programs/awesome.nix
  	../../../all/home-manager/common/programs/gh.nix
  	../../../all/home-manager/common/programs/git.nix
  	../../../all/home-manager/common/programs/gtk.nix
  	../../../all/home-manager/common/programs/rofi.nix
  	../../../all/home-manager/common/programs/sxhkd.nix
  	../../../all/home-manager/common/programs/zsh.nix
    ../../../all/home-manager/common/programs/tmux.nix
    ../../../all/home-manager/common/programs/dmenu.nix
    ../../../all/home-manager/common/programs/xorg.nix
    ../../../all/home-manager/common/programs/gpg.nix
    ../../../all/home-manager/common/programs/picom.nix
    ../../../all/home-manager/common/programs/cmus.nix
    ./programs/kitty.nix
    ./programs/packages.nix
    ./programs/packages-ygt.nix
    ./programs/sesh.nix
    ./programs/starship.nix
  ];
}
