{ pkgs? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3;
  solargraph = pkgs.rubyPackages_3_3.solargraph;
  rubyEnv = pkgs.bundlerEnv {
    name = "wss-bundler-env";
    inherit ruby;
    gemfile = ~/code/ygt/spabreaks/Gemfile;
    lockfile = ~/code/ygt/spabreaks/Gemfile.lock;
    gemset = ~/code/ygt/spabreaks/gemset.nix;
  };
in
pkgs.stdenv.mkDerivation {
  name = "wss-env";
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
