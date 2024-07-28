{ config, pkgs, ... }:

{
  home.username = "ygt";
  home.homeDirectory = "/home/ygt";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    go-task
    google-cloud-sdk
    sops
    bundix
    slack
    gcc
  ];

  imports = [
    ../common/programs/packages.nix
  	../common/programs/awesome.nix
  	../common/programs/media.nix
  	../common/programs/neovim
  	../common/programs/zsh.nix
    ../common/programs/firefox.nix
    ../common/programs/git.nix
    ../common/programs/gtk.nix
    ../common/programs/qt.nix
    ../common/programs/rofi.nix
    ../common/programs/tmux.nix
    ../common/programs/picom.nix
    ../common/programs/terminal.nix
    ../common/programs/sxhkd.nix
    ../common/programs/kitty.nix
    ../common/programs/dmenu.nix
    ../common/programs/xorg.nix
    ../common/programs/gh.nix
  ];
}
