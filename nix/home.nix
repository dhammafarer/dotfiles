{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    eza
    fzf
    jq
    ripgrep
    tree
    which
  ];

  imports = [
	./modules/ygt.nix
  	./programs/git.nix
  	./programs/zsh.nix
  	./programs/neovim
  	./modules/ruby.nix
  ];
}
