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
        error_symbol = "[✗](bold red)";
      };
      package = {
        disabled = true;
      };
      cmd_duration = {
        min_time = 5000;
        format = "[$duration](bold yellow)";
      };
      directory = {
        truncate_to_repo = true;
      };
      format = lib.concatStrings [
        "$directory"
        "$shell"
        "$nix_shell"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$line_break"
        "$character"
        #"$username"
        #"$hostname"
        #"$localip"
        #"$shlvl"
        #"$singularity"
        #"$kubernetes"
        #"$vcsh"
        #"$fossil_branch"
        #"$fossil_metrics"
        #"$hg_branch"
        #"$pijul_channel"
        #"$docker_context"
        #"$package"
        #"$c"
        #"$cmake"
        #"$cobol"
        #"$daml"
        #"$dart"
        #"$deno"
        #"$dotnet"
        #"$elixir"
        #"$elm"
        #"$erlang"
        #"$fennel"
        #"$gleam"
        #"$golang"
        #"$guix_shell"
        #"$haskell"
        #"$haxe"
        #"$helm"
        #"$java"
        #"$julia"
        #"$kotlin"
        #"$gradle"
        #"$lua"
        #"$nim"
        #"$nodejs"
        #"$ocaml"
        #"$opa"
        #"$perl"
        #"$php"
        #"$pulumi"
        #"$purescript"
        #"$python"
        #"$quarto"
        #"$raku"
        #"$rlang"
        #"$red"
        #"$ruby"
        #"$rust"
        #"$scala"
        #"$solidity"
        #"$swift"
        #"$terraform"
        #"$typst"
        #"$vlang"
        #"$vagrant"
        #"$zig"
        #"$buf"
        #"$conda"
        #"$meson"
        #"$spack"
        #"$memory_usage"
        #"$aws"
        #"$gcloud"
        #"$openstack"
        #"$azure"
        #"$nats"
        #"$direnv"
        #"$env_var"
        #"$crystal"
        #"$custom"
        #"$sudo"
        #"$cmd_duration"
        #"$line_break"
        #"$jobs"
        #"$battery"
        #"$time"
        #"$status"
        #"$os"
        #"$container"
        #"$shell"
      ];
    };
  };
}
