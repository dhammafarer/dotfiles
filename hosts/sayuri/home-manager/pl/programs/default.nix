{ pkgs, config, lib, ... }: {

  imports = [
    ./common.nix
    ./kitty.nix
    ./packages-ygt.nix
    ./packages.nix
    ./sesh.nix
    ./starship.nix
  ];
}
