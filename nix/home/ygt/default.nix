{ config, pkgs, ... }:

{
  home.username = "ygt";
  home.homeDirectory = "/home/ygt";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    acpi
    bat
    eza
    fzf
    firefox
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
    unclutter-xfixes
    playerctl
  ];

  programs.firefox = {
    enable = true;
  };

  imports = [
	#../modules/ygt.nix
  	../programs/git.nix
  	../programs/zsh.nix
  	../programs/media.nix
  	../programs/neovim
  	# ./modules/ruby.nix
  ];
}
