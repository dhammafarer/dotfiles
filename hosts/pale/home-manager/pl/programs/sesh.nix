{ config, ... }:

{
  home.file."${config.xdg.configHome}/sesh/sesh.toml" = {
	source = ../../../config/sesh/sesh.toml;
  };
}
