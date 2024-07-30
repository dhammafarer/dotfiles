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
            "log/test.log.0"
        ];
        hooks = {
          pre-commit = ../config/git/hooks/pre-commit;
        };
        extraConfig = {
            init.defaultBranch = "master";
            pull.rebase = false;
        };
    };
}
