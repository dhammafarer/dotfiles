{ config, pkgs, ... }:

{
  home.file.".gnupg/gpg-agent.conf" = {
	source = ../../../config/gnupg/gpg-agent.conf;
  };
}
