{ pkgs? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3;
  solargraph = pkgs.rubyPackages_3_3.solargraph;
  rubyEnv = pkgs.bundlerEnv {
    name = "booking-transform-bundler-env";
    inherit ruby;
    gemfile = ~/code/ygt/booking-transform/Gemfile;
    lockfile = ~/code/ygt/booking-transform/Gemfile.lock;
    gemset = ~/code/ygt/booking-transform/gemset.nix;
  };
in
pkgs.stdenv.mkDerivation {
  name = "booking-transform-env";
  buildInputs = with pkgs; [
    rubyEnv
    ruby
    solargraph
    nodejs_22
    sops
    typescript
    yarn
  ];
}
