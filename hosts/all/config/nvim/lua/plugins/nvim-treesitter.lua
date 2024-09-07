-- Ansible managed: templates/lua/plugins/nvim-treesitter.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

vim.opt.runtimepath:append("$HOME/.local/share/nvim/lazy/nvim-treesitter")

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
                  "vimdoc",
                        "bash",
                        "ini",
                        "json",
                        "yaml",
                        "git_config",
                        "gitignore",
                        "sxhkdrc",
                        "c",
                        "cmake",
                        "rust",
                        "toml",
                        "lua",
                        "python",
                        "javascript",
                        "typescript",
                        "html",
                        "css",
                        "astro",
                        "dockerfile",
                        "go",
                        "ruby",
                                  "vue",
            },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  parser_install_dir ="$HOME/.local/share/nvim/lazy/nvim-treesitter",

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
