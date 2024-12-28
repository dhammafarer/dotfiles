{ config, pkgs, ... }:

{
  home.file."${config.xdg.configHome}/awesome-test" = {
    source = builtins.fetchGit {
      url = "https://github.com/palekiwi/awesome";
      rev = "d554dd526b59d46ad79b482d4b58e4b27191757f";
    };
  };

  home.file."${config.xdg.configHome}/awesome/lain" = {
    source = builtins.fetchGit {
      url = "https://github.com/lcpz/lain";
      rev = "88f5a8abd2649b348ffec433a24a263b37f122c0";
    };
  };
}
