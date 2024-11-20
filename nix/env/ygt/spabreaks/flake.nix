{
  description = "Spabreaks Dev Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sqlfluff_0_8_2.url = "github:nixos/nixpkgs?rev=61d24cba72831201efcab419f19b947cf63a2d61";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      sqlfluff = inputs.sqlfluff_0_8_2.legacyPackages.${system}.sqlfluff;
      ruby = pkgs.ruby_3_3;

      gems = pkgs.bundlerEnv {
        name = "spabreaks-bundler-env";
        inherit ruby;
        gemfile = ./Gemfile;
        lockfile = ./Gemfile.lock;
        gemset = ./gemset.nix;
      };
    in
    {
      devShells.x86_64-linux.default = import ./shell.nix { inherit pkgs; };
    };
}
