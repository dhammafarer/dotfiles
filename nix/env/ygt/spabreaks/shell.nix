{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
    nativeBuildInputs = with pkgs; [
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
