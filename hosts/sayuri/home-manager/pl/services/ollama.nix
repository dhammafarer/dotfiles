{ pkgs, ... }:

{
  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      After = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "ollama-serve" ''
        ${pkgs.ollama}/bin/ollama serve
      ''}";
    };
  };
}

