{ config, pkgs, inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-capslock = prev.vimUtils.buildVimPlugin {
            name = "capslock";
            src = inputs.plugin-capslock;
          };
          own-kiwi = prev.vimUtils.buildVimPlugin {
            name = "kiwi";
            src = inputs.plugin-kiwi;
          };
          own-prettier = prev.vimUtils.buildVimPlugin {
            name = "prettier";
            src = inputs.plugin-prettier;
          };
        };
      })
    ];
  };
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

      extraLuaConfig = (builtins.readFile ./settings.lua)
        + (builtins.readFile ./mappings.lua);

      extraPackages = with pkgs; [
        nixpkgs-fmt
        go
        nodePackages.prettier
        ctags
        xclip
        luajitPackages.luarocks
        luajitPackages.lua-lsp
        nixd
      ];

      plugins = with pkgs.vimPlugins; [

        plenary-nvim
        which-key-nvim
        nvim-web-devicons
        vim-visual-multi
        vim-floaterm
        lspkind-nvim

        { plugin = nvim-lspconfig; config = toLuaFile ./plugins/lsp.lua; }
        { plugin = nvim-tree-lua; config = toLuaFile ./plugins/tree.lua; }
        { plugin = nightfox-nvim; config = toLuaFile ./plugins/nightfox.lua; }
        { plugin = nightfox-nvim; config = toLuaFile ./plugins/nightfox.lua; }
        { plugin = lualine-nvim; config = toLuaFile ./plugins/lualine-nvim.lua; }
        { plugin = telescope-nvim; config = toLuaFile ./plugins/telescope-nvim.lua; }
        { plugin = barbar-nvim; config = toLuaFile ./plugins/barbar.lua; }
        { plugin = hop-nvim; config = toLuaFile ./plugins/hop.lua; }
        { plugin = nvim-autopairs; config = toLuaFile ./plugins/nvim-autopairs.lua; }
        { plugin = nvim-surround; config = toLuaFile ./plugins/nvim-surround.lua; }
        { plugin = nvim-notify; config = toLuaFile ./plugins/nvim-notify.lua; }
        { plugin = indent-blankline-nvim; config = toLuaFile ./plugins/indent-blankline.lua; }
        { plugin = own-capslock; config = toLuaFile ./plugins/capslock.lua; }
        { plugin = own-kiwi; config = toLuaFile ./plugins/kiwi.lua; }
        { plugin = gitsigns-nvim; config = toLuaFile ./plugins/gitsigns.lua; }
        { plugin = luasnip; config = toLuaFile ./plugins/luasnip.lua; }
        { plugin = nvim-cmp; config = toLuaFile ./plugins/nvim-cmp.lua; }
        { plugin = nvim-cmp; config = toLuaFile ./plugins/nvim-cmp.lua; }
        { plugin = none-ls-nvim; config = toLuaFile ./plugins/null-ls.lua; }
        { plugin = neodev-nvim; config = toLuaFile ./plugins/neodev.lua; }
        { plugin = own-prettier; config = toLuaFile ./plugins/prettier.lua; }
        telescope-ui-select-nvim
        vim-gutentags
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp-signature-help

        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-json
          p.tree-sitter-markdown
          p.tree-sitter-markdown_inline
        ]))
      ];
    };
}
