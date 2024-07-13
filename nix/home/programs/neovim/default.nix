{ config, pkgs, ... }:

{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./settings.lua;

    extraPackages = with pkgs; [
      go
      xclip
      luajitPackages.luarocks
      luajitPackages.lua-lsp
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./plugins/tree.lua;
      }

      {
        plugin = nightfox-nvim;
        config = toLuaFile ./plugins/nightfox.lua;
      }

      

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-json
      ]))
    ];
  };
}
