local set = vim.opt

set.termguicolors = true

set.title = true
set.titlestring = "[vim] %t (%{expand('%:p:h')})"

--vim.notify = require("notify")

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
--set.wrap = false
set.scrolloff = 5
set.fileencoding = 'utf-8'

set.number = true
set.relativenumber = false
set.cursorline = false

set.timeout = true
set.timeoutlen = 300

set.hidden = true
set.completeopt = 'menuone,noselect'

set.foldlevel = 1
set.foldmethod = "indent"
set.foldexpr = "nvim_treesitter#foldexpr()"

vim.api.nvim_set_option("clipboard", "unnamed")
