{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        userName = "Pawel Lisewski";
        userEmail = "dev@palekiwi.com";
        ignores = [
            "*.swp"
            ".direnv"
            ".envrc"
            ".gutctags"
            "build"
            "gemset.nix"
            "tags"
        ];
        extraConfig = {
            init.defaultBranch = "master";
            pull.rebase = false;
        };
    };
}
