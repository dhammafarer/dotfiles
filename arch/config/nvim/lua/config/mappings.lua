vim.g.mapleader = ','

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- vim.diagnostic
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>E', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

map('n', '<leader>n', ':NvimTreeToggle<CR>', opts)

map('n', '<leader>w', ':write<CR>', opts)
map('n', '<leader>x', ':quit<CR>', opts)

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- ChatGPT
map('n', '<leader>v', '<Cmd>ChatGPTEditWithInstructions<CR>', opts)

-- Dap
map('n', '<leader>dt', '<Cmd>DapToggleBreakpoint<CR>', opts)
map('n', '<leader>dx', '<Cmd>DapTerminate<CR>', opts)
map('n', '<leader>ds', '<Cmd>DapStepOver<CR>', opts)

-- FloatTerm
map('n', "<leader>ft", "<Cmd>FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh<CR>", opts)
map('n', "<leader>fg", "<Cmd>FloatermNew --name=gitui --height=0.8 --width=0.7 --autoclose=2 gitui<CR>", opts)
map('n', "t", "<Cmd>FloatermToggle myfloat<CR>", opts)
map('t', "<Esc>", "<C-\\><C-n>:q<CR>", opts)

-- HopLine
map('n', 'l', ':HopLine<CR>', opts)

-- HopLineStart
map('n', '<S-l>', ':HopLineStart<CR>', opts)

-- overwrite switching from SELECT to VISUAL mode during snippet expansion
map('s', 's', 's', opts)
