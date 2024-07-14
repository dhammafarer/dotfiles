{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
    nativeBuildInputs = with pkgs; [
        ruby_3_3
        rubyPackages_3_3.solargraph
        rubyPackages_3_3.rubocop
    ];
}
