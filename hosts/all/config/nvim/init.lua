-- Ansible managed: templates/init.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('plugins.lazy')

require('plugins.nightfox')
require('plugins.gruvbox')
require('plugins.nvim-tree')
require('plugins.neo-tree')
require('plugins.nvim-notify')
require('plugins.barbar')
require('plugins.hop')
require('plugins.lualine')
require('plugins.nvim-autopairs')
require('plugins.nvim-surround')
require('plugins.telescope')
require('plugins.indent-blankline')
require('plugins.capslock')
require('plugins.vimwiki')
require('plugins.ollama')
require('plugins.gitsigns')
require('plugins.null-ls')
require('plugins.mason')
require('plugins.mason-lspconfig')
require('plugins.mason-null-ls')
require('plugins.mason-nvim-dap')
require('plugins.neodev')
require('plugins.nvim-lspconfig')
require('plugins.prettier')
require('plugins.nvim-cmp')
require('plugins.luasnip')
require('plugins.nvim-dap-ui')
require('plugins.yaml-companion')
require('plugins.nvim-treesitter')
require('plugins.nvim-treesitter-text-objects')

require('config.settings')
require('config.mappings')
