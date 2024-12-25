{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gnumake
    go-task
    google-cloud-sdk
    slack
    sops
  ];
}
