{ config, pkgs, ... }:

{
  #home.file."${config.xdg.configHome}/awesome.b/tags.lua".source = /home/pl/dotfiles/fedora/config/awesome/tags.lua;

  #home.file."${config.xdg.configHome}/awesome.b/widgets" = {
  #  source = ./${dir}/widgets;
  #  recursive = true;
  #};

}
