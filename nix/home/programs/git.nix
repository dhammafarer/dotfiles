{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pawel Lisewski";
    userEmail = "dev@palekiwi.com";
    ignores = [
	"*.swp"
	"build"
	"tags"
    ];
    extraConfig = {
	init.defaultBranch = "master";
	pull.rebase = false;
    };
  };
}
