{ pkgs? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3;
  solargraph = pkgs.rubyPackages_3_3.solargraph;
  rubyEnv = pkgs.bundlerEnv {
    name = "sb-voucher-redemptions-bundler-env";
    inherit ruby;
    gemfile = ~/code/ygt/sb-voucher-redemptions/Gemfile;
    lockfile = ~/code/ygt/sb-voucher-redemptions/Gemfile.lock;
    gemset = ~/code/ygt/sb-voucher-redemptions/gemset.nix;
  };
in
pkgs.stdenv.mkDerivation {
  name = "sb-voucher-redemptions-env";
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
