{ config, pkgs, ... }:

{
  home.username = "pl";
  home.homeDirectory = "/home/pl";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  services.gpg-agent.pinentryPackage = pkgs.pinentry-gtk2;

  programs.home-manager.enable = true;

  imports = [
    ./programs
  ];
}
