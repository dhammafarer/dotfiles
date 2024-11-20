{ pkgs? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3;
  solargraph = pkgs.rubyPackages_3_3.solargraph;
  rubyEnv = pkgs.bundlerEnv {
    name = "spabreaks-bundler-env";
    inherit ruby;
    gemfile = ~/code/ygt/spabreaks/Gemfile;
    lockfile = ~/code/ygt/spabreaks/Gemfile.lock;
    gemset = ~/code/ygt/spabreaks/gemset.nix;
  };
in
pkgs.stdenv.mkDerivation {
  name = "spabreaks-env";
  buildInputs = with pkgs; [
    rubyEnv
    ruby
    solargraph
    elmPackages.elm
    elmPackages.elm-test
    elmPackages.elm-format
    elmPackages.elm-analyse
    elmPackages.elm-language-server
    nodejs_22
    sops
    typescript
    yarn
  ];
}
