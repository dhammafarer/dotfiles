with (import <nixpkgs> { });

let
  ruby = ruby_3_3;
  solargraph = rubyPackages_3_3.solargraph;
  env = bundlerEnv {
    name = "spabreaks-bundler-env";
    inherit ruby;
    gemfile = ~/code/ygt/spabreaks/Gemfile;
    lockfile = ~/code/ygt/spabreaks/Gemfile.lock;
    gemset = ~/code/ygt/spabreaks/gemset.nix;
  };
in
stdenv.mkDerivation {
  name = "spabreaks";
  buildInputs = [
    env
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
