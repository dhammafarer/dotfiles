with (import <nixpkgs> {});
let
  ruby = ruby_3_3;
  solargraph = rubyPackages_3_3.solargraph;
  elm = elmPackages.elm;
  elm-test = elmPackages.elm-test;
  elm-format = elmPackages.elm-format;
  elm-analyse = elmPackages.elm-analyse;
  env = bundlerEnv {
    name = "spabreaks-bundler-env";
    inherit ruby;
    gemfile  = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset   = ./gemset.nix;
  };
in stdenv.mkDerivation {
  name = "spabreaks";
  buildInputs = [ env ruby solargraph elm elm-analyse elm-test elm-format ];
}
