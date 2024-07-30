{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    acpi
    arc-icon-theme
    bat
    bundix
    cmus
    dmenu
    eza
    fasd
    fira-code-nerdfont
    fzf
    gh
    gh-f
    gh-s
    git
    gitui
    gnumake
    google-chrome
    jetbrains-mono
    jq
    kdePackages.breeze-gtk
    lua
    maim
    neovim
    nodePackages.prettier
    nodejs_22
    pass
    playerctl
    ranger
    ripgrep
    sops
    starship
    tldr
    tmux
    tree
    unclutter-xfixes
    universal-ctags
    which
    xclip
    xdotool
    xorg.xev
    xorg.xset
    signal-desktop
    slack
    firefox
    docker-compose
  ];

  imports = [
    ./starship.nix
    ./neovim.nix
  	../common/programs/zsh.nix
  	../common/programs/gh.nix
  	../common/programs/git.nix
  	../common/programs/sxhkd.nix
  	../common/programs/rofi.nix
    ../common/programs/tmux.nix
  ];
}
