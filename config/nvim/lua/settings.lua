local set = vim.opt

--vim.notify = require("notify")

set.expandtab = true
set.smarttab = true
set.shiftwidth = 2
set.tabstop = 2

set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = false
set.scrolloff = 5
set.fileencoding = 'utf-8'
set.termguicolors = true

set.relativenumber = true
set.cursorline = false

set.hidden = true
set.completeopt = 'menuone,noselect'

vim.api.nvim_set_option("clipboard","unnamed")

vim.filetype.add({
  pattern = {
    ['.*/playbooks?/.*.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*.ya?ml'] = 'yaml.ansible',
    ['.*/handlers/.*.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*.ya?ml'] = 'yaml.ansible',
  },
})
