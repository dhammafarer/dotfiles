{ pkgs? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3;
  solargraph = pkgs.rubyPackages_3_3.solargraph;
in
pkgs.stdenv.mkDerivation {
  name = "ygt-ruby-env";
  buildInputs = with pkgs; [
    ruby
    solargraph
    nodejs_22
    sops
    typescript
    yarn
  ];
}
