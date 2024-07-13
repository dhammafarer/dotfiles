{
    description = "My Home Manager Flake";

    inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        home-manager = {
	    url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...}: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        homeConfigurations = {
            pl = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };

                modules = [ ./home.nix ];
            };

            ygt = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };

                modules = [ ./home/ygt/default.nix ];
            };
        };
    };
}
