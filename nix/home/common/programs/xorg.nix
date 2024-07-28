{ config, pkgs, ... }:

{
  home.file.".Xmodmap".text = ''
    pointer = 1 3 2 4 5 7 6 8 9 10 11 12
    keycode 192 = ISO_Level3_Shift
  '';
}
