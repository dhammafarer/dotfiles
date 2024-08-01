with (import <nixpkgs> { });

let
  pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/0229135d7a2eedc5490cafb8c61562f71c6d357b.tar.gz";
    }) {};

  sqlfluff_0_8_2 = pkgs.sqlfluff;
in
stdenv.mkDerivation {
  name = "spabreaks-cli";
  buildInputs = [
    sqlfluff_0_8_2
  ];
}
