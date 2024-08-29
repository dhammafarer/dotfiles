{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible
    ansible-lint
    acpi
    arc-icon-theme
    bat
    cmus
    dmenu
    docker-compose
    eza
    fasd
    fira-code-nerdfont
    firefox
    fzf
    gh
    gh-f
    gh-s
    git
    gitui
    gnumake
    google-chrome
    gpick
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
    signal-desktop
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
    freeplane
    home-assistant-cli
    # ibus-with-plugins
    # ibus
    # ibus-engines.libpinyin
  ];
}
