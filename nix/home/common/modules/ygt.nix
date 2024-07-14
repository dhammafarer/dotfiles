{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-compose
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-language-server
    gnumake
    go-task
    google-cloud-sdk
    nodejs_22
    sops
    typescript
    yarn
  ];
}
