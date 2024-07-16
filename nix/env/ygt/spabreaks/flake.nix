{
  description = "A Nix-flake-based Node.js development environment";

  #inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; };
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.x86_64-linux.default = import ./shell.nix { inherit pkgs; };
  };
}
