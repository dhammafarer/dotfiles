{
    description = "My Home Manager Flake";

    inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        home-manager = {
	    url = "github:nix-community/home-manager/release-24.05";
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

                modules = [ ./home/pl/default.nix ];

                extraSpecialArgs = { inherit inputs; };
            };

            ygt = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };

                modules = [ ./home/ygt/default.nix ];

                extraSpecialArgs = { inherit inputs; };
            };
        };
    };
}
