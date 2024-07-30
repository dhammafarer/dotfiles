{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      package = {
        disabled = true;
      };
      cmd_duration = {
        min_time = 5000;
        format = "[$duration](bold yellow)";
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style)";
        style = "bold green";
      };
      git_metrics = {
        disabled = true;
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "red";
        conflicted  = "";
        untracked = " ($count)";
        modified  = " ($count)";
        staged    = " ($count)";
        renamed   = " 󰁕($count)";
        deleted   = " ✖($count)";
      };
      nix_shell = {
        format = "[$symbol$state( \($name\))]($style)";
        symbol = "❄";
        style = "bold blue";
        impure_msg = "";
      };
      directory = {
        truncate_to_repo = true;
      };
      format = lib.concatStrings [
        "$directory"
        " "
        "$git_branch"
        "$git_state"
        "$git_metrics"
        "$git_status"
        " "
        "$nix_shell"
        "$line_break"
        "$character"
      ];
    };
  };
}
