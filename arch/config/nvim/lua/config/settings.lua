-- Ansible managed: templates/lua/config/settings.lua.j2 modified on 2023-07-20 19:06:46 by pl on dev.ctn
local set = vim.opt

set.termguicolors = true

set.title = true
set.titlestring = "%t (%{expand('%:p:h')})"

vim.notify = require("notify")

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
set.wrap = false
set.scrolloff = 5
set.fileencoding = 'utf-8'

set.number = true
set.relativenumber = true
set.cursorline = false

set.timeout = true
set.timeoutlen = 300

set.hidden = true
set.completeopt = 'menuone,noselect'

set.foldlevel = 1
set.foldmethod = "indent"
set.foldexpr = "nvim_treesitter#foldexpr()"

vim.api.nvim_set_option("clipboard", "unnamed")

-- python indent
vim.g["python_indent"] = {
    disable_parentheses_indenting = 'v:false',
    closed_paren_align_last_line = 'v:false',
    searchpair_timeout = '150',
    continue = 'shiftwidth() * 1',
    open_paren = 'shiftwidth() * 1',
    nested_paren = 'shiftwidth()'
}

-- workaround needed to trigger folding on file opening
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = { "*" },
--     command = "normal zx",
-- })

--vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileReadPost" }, {
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*" },
    command = "set foldlevel=99",
})

vim.g["codeium_enabled"] = 'v:false'

vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    command = "setlocal autoindent"
})

vim.diagnostic.config({
    virtual_text = false
})

vim.filetype.add({
  pattern = {
    ['.*/playbooks?/.*.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*.ya?ml'] = 'yaml.ansible',
    ['.*/handlers/.*.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*.ya?ml'] = 'yaml.ansible',
    ['.*/molecule/.*.ya?ml'] = 'yaml.ansible',
    ['.*.lua.j2'] = 'lua.j2',
    ['.*.gohtml'] = 'html',
    ['.*go.mod'] = 'gomod',
    ['.*.bu'] = 'yaml',
  },
})
