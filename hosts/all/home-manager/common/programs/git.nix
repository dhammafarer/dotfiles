{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        userName = "Pawel Lisewski";
        userEmail = "dev@palekiwi.com";
        signing = {
            key = "848E5BB30B98EB1D2714BCCB44766C74B3546A52";
            signByDefault = true;
        };
        ignores = [
            "*.swp"
            ".direnv"
            ".envrc"
            ".gutctags"
            "gemset.nix"
            "tags"
            "vendor/bundle"
            "tags.lock"
            "tags.temp"
            "build"
            "log/test.log.0"
            "tmux-client-*"
        ];
        # hooks = {
        #   pre-commit = ../../../config/git/hooks/pre-commit;
        # };
        extraConfig = {
            init.defaultBranch = "master";
            pull.rebase = false;
        };
    };
}
