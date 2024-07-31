{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bundix
    gcc
    gnumake
    go-task
    google-cloud-sdk
    slack
    sops
  ];
}
