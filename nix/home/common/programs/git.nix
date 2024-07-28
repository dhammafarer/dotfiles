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
            "tags"
            "tags.lock"
            "build"
            "gemset.nix"
        ];
        extraConfig = {
            init.defaultBranch = "master";
            pull.rebase = false;
        };
    };
}
