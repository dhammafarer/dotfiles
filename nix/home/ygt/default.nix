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
    acpi
    bat
    eza
    fasd
    maim
    fzf
    git
    gitui
    google-chrome
    jq
    pass
    ranger
    ripgrep
    tree
    which
    tldr
    arc-icon-theme
    fira-code-nerdfont
    jetbrains-mono
    unclutter-xfixes
    playerctl
  ];

  imports = [
  	../common/programs/media.nix
  	../common/programs/neovim
  	../common/programs/zsh.nix
    ../common/programs/firefox.nix
    ../common/programs/git.nix
    ../common/programs/gtk.nix
    ../common/programs/qt.nix
    ../common/programs/rofi.nix
    ../common/programs/tmux.nix
  ];
}
