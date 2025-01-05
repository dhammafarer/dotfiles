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

    outputs = {nixpkgs, home-manager, ...}@inputs: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        homeConfigurations = {
            pl = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };

                modules = [ ./pl/default.nix ];

                extraSpecialArgs = { inherit inputs; };
            };
        };
    };
}
