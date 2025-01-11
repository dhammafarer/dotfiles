{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-capslock.url = "github:barklan/capslock.nvim";
    plugin-capslock.flake = false;

    plugin-kiwi.url = "github:serenevoid/kiwi.nvim";
    plugin-kiwi.flake = false;

    plugin-prettier.url = "github:MunifTanjim/prettier.nvim";
    plugin-prettier.flake = false;
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    # defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      homeConfigurations = {
        pl = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./pl/default.nix ];

          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
