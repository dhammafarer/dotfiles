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
        lua-language-server
        nixd
      ];

      plugins = with pkgs.vimPlugins; [
        plenary-nvim
        nvim-web-devicons
        nvim-web-devicons
        nui-nvim

        { plugin = nvim-treesitter.withAllGrammars; config = toLua "require('nvim-treesitter').setup()"; }
        { plugin = nvim-lspconfig; config = toLuaFile ./plugins/lsp.lua; }
        { plugin = neo-tree-nvim; config = toLuaFile ./plugins/neotree.lua; }
        { plugin = nightfox-nvim; config = toLuaFile ./plugins/nightfox.lua; }
        { plugin = lualine-nvim; config = toLuaFile ./plugins/lualine.lua; }
        { plugin = telescope-nvim; config = toLuaFile ./plugins/telescope.lua; }
        { plugin = barbar-nvim; config = toLuaFile ./plugins/barbar.lua; }
        { plugin = nvim-notify; config = toLuaFile ./plugins/notify.lua; }
        { plugin = indent-blankline-nvim; config = toLuaFile ./plugins/indent-blankline.lua; }
        { plugin = gitsigns-nvim; config = toLuaFile ./plugins/gitsigns.lua; }
        { plugin = luasnip; config = toLuaFile ./plugins/luasnip.lua; }
        { plugin = nvim-cmp; config = toLuaFile ./plugins/cmp.lua; }
        { plugin = none-ls-nvim; config = toLuaFile ./plugins/null-ls.lua; }
        { plugin = own-prettier; config = toLuaFile ./plugins/prettier.lua; }
        { plugin = own-kiwi; config = toLuaFile ./plugins/kiwi.lua; }

        { plugin = hop-nvim; config = toLua "require('hop').setup()"; }
        { plugin = nvim-autopairs; config = toLua "require('nvim-autopairs').setup()"; }
        { plugin = own-capslock; config = toLua "require('capslock').setup()"; }
        { plugin = neodev-nvim; config = toLua "require('neodev').setup()"; }
        { plugin = nvim-surround; config = toLua "require('nvim-surround').setup()"; }

        which-key-nvim
        vim-visual-multi
        vim-floaterm
        lspkind-nvim
        cmp-nvim-lsp
        telescope-ui-select-nvim
        vim-gutentags
        cmp-path
        cmp_luasnip
        cmp-nvim-lsp-signature-help

        # (nvim-treesitter.withPlugins (p: [
        #   p.tree-sitter-bash
        #   p.tree-sitter-json
        #   p.tree-sitter-lua
        #   p.tree-sitter-nix
        #   p.tree-sitter-markdown
        #   p.tree-sitter-markdown_inline
        #   p.tree-sitter-ruby
        #   p.tree-sitter-vim
        # ]))
        nvim-treesitter.withAllGrammars
      ];
    };

  home.file."${config.xdg.configHome}/nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };
}
