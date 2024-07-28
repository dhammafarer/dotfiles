{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_family = "FiraCode Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "16.0";
      copy_on_select = "yes";
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_beam_thickness = "1.0";
      cursor_blink_interval = "0";
      enable_audio_bell = "no";
      cursor = "none";
      foreground = "#c5c8c6";
      background = "#1d1f21";
      color0 = "#282a2e";
      color1 = "#a54242";
      color2 = "#6e9440";
      color3 = "#de935f";
      color4 = "#5f819d";
      color5 = "#85678f";
      color6 = "#5e8d87";
      color7 = "#707880";
      color8 = "#373b41";
      color9 = "#cc6666";
      color10 = "#9dbd68";
      color11 = "#f0c674";
      color12 = "#81a2be";
      color13 = "#b294bb";
      color14 = "#8abeb7";
      color15 = "#c5c8c6";
    };
  };
}
