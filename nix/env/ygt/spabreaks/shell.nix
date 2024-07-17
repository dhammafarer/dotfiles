with (import <nixpkgs> { });

let
  ruby = ruby_3_3;
  solargraph = rubyPackages_3_3.solargraph;
  env = bundlerEnv {
    name = "spabreaks-bundler-env";
    inherit ruby;
    gemfile = /home/ygt/code/spabreaks/Gemfile;
    lockfile = /home/ygt/code/spabreaks/Gemfile.lock;
    gemset = /home/ygt/code/spabreaks/gemset.nix;
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
    elmPackages.elm-language-server
    nodejs_22
    sops
    typescript
    yarn
  ];
}
