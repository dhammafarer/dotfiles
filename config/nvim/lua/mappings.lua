vim.g.mapleader = ','

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>n', ':NvimTreeToggle<CR>', opts)
