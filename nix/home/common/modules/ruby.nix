{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
  ];

  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;
    plugins = [
      {
        name = "ruby-build";
        src = pkgs.fetchFromGitHub {
          owner = "rbenv";
          repo = "ruby-build";
          rev = "v20240702";
          hash = "sha256-ZFpTNyOLNc0f+QPBW2Dos7CEOuTwT9+xprNYJzp0mdE=";
        };
      }
    ];
  };
}
