local wk = require("which-key")
local kiwi = require('kiwi')

local helpers = require('config.utils.helpers')
local telescope_utils = require('config.utils.telescope')
local gh_utils = require('config.utils.gh')
local git_utils = require('config.utils.git')
local rails_utils = require('config.utils.rails')

vim.g.mapleader = ","

vim.keymap.set({ 'n', 'v' }, '<Down>', 'gj')
vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')

vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true, silent = true })

local base = {
  { "<A-,>",      "<cmd>BufferPrevious<cr>",                                                           desc = "Previous Buffer" },
  { "<A-.>",      "<cmd>BufferNext<cr>",                                                               desc = "Next Buffer" },
  { "<A-/>",      "<cmd>BufferPrevious<cr>",                                                           desc = "Go to Previous" },
  { "<A-<>",      "<cmd>BufferMovePrevious<cr>",                                                       desc = "Move Previous Buffer" },
  { "<A->>",      "<cmd>BufferMoveNext<cr>",                                                           desc = "Move Next Buffer" },
  { "<A-c>",      gh_utils.copy_file_url,                                                              desc = "Copy gh file url" },
  { "<A-d>",      gh_utils.copy_diff_url,                                                              desc = "Copy gh diff url" },
  { "<A-f>",      "<cmd>Telescope live_grep<cr>",                                                      desc = "Live Grep" },
  { "<A-g>",      telescope_utils.git_commits,                                                         desc = "Find template in views" },
  { "<A-h>",      "<cmd>BufferFirst<cr>",                                                              desc = "Go to First" },
  { "<A-l>",      "<cmd>set cursorline!<cr>",                                                          desc = "Toggle Cursorline" },
  { "<A-m>",      "zMzA",                                                                              desc = "Toggle Fold" },
  { "<A-n>",      "<Plug>CapsLockToggle",                                                              desc = "Toggle Capslock",                   mode = "i" },
  { "<A-q>",      "<cmd>BufferClose<cr>",                                                              desc = "Close Buffer" },
  { "<A-s>",      "<cmd>A<cr>",                                                                        desc = "Find Spec" },
  { "<A-t>",      "<Cmd>FloatermToggle first<CR>",                                                     desc = "Toggle first terminal" },
  { "<A-t>",      rails_utils.find_template_render,                                                    desc = "Find template in views" },
  { "<A-v>",      rails_utils.find_template,                                                           desc = "Views" },
  { "<A-w>",      "<cmd>Telescope grep_string word_match=-w<cr>",                                      desc = "String Grep" },
  { "<A-x>",      "<cmd>BufferCloseAllButCurrent<cr>",                                                 desc = "Close Buffer All But Current" },
  { "<A-z>",      "za",                                                                                desc = "Toggle Fold" },
  { "<C-b>",      "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>",               desc = "Buffers" },
  { "<C-d>",      vim.diagnostic.goto_next,                                                            desc = "Diagnostics Next" },
  { "<C-d>",      vim.lsp.buf.definition,                                                              desc = "[LSP] Go to Definition" },
  { "<C-e>",      "<cmd>Telescope oldfiles cwd_only=true<cr>",                                         desc = "Recent Files" },
  { "<C-f>",      "<cmd>Telescope find_files<cr>",                                                     desc = "Find File" },
  { "<C-f>",      function() vim.lsp.buf.format { async = true } end,                                  desc = "LSP Format",                        mode = "i" },
  { "<C-h>",      vim.lsp.buf.signature_help,                                                          desc = "LSP Signature help" },
  { "<C-p>",      telescope_utils.changed_files,                                                       desc = "Search changed files" },
  { "<C-q>",      "<cmd>Telescope quickfix show_line=false<cr>",                                       desc = "Quickfix" },
  { "<C-s>",      "<cmd>Telescope current_buffer_tags show_line=true<cr>",                             desc = "Tags" },
  { "<C-space>",  vim.lsp.buf.hover,                                                                   desc = "LSP Hover" },
  { "<C-t>",      telescope_utils.search_tags,                                                         desc = "Find tag" },
  { "<C-u>",      telescope_utils.lsp_references,                                                      desc = "Ref" },
  { "<Esc>",      "<C-\\><C-n>:q<CR>",                                                                 desc = "Close floatterm",                   mode = "t" },
  { "<F4>",       "<C-R>=strftime('%T')<cr>",                                                          desc = "Insert time",                       mode = "i" },
  { "<F5>",       "<C-R>=strftime('%Y-%m-%d %a')<cr>",                                                 desc = "Insert date with weekday",          mode = "i" },
  { "<F6>",       "<C-R>=strftime('%F')<cr>",                                                          desc = "Insert date",                       mode = "i" },
  { "<F8>",       "<C-R>=expand('%:t')<cr>",                                                           desc = "Insert current filename",           mode = "i" },
  { "<leader>c",  "<cmd>let @+=expand('%')<cr>",                                                       desc = "copy current filepath to clipboard" },
  { "<leader>d",  "<cmd>Gitsigns diffthis<cr>",                                                        desc = "Diff this" },
  { "<leader>f",  function() vim.lsp.buf.format { async = true } end,                                  desc = "LSP Format" },
  { "<leader>gy", "<cmd>Telescope grep_string search_dirs=webpack/src/styles<cr>",                     desc = "Grep Styles" },
  { "<leader>h",  "<cmd>Gitsigns toggle_deleted<cr>",                                                  desc = "Deleted" },
  { "<leader>m",  function() git_utils.toggle_git_status("focus", true, false, "right", "master") end, desc = "Change base: master" },
  { "<leader>n",  function() git_utils.toggle_git_status("focus", true, false, "right", nil) end,      desc = "Tree: Git status" },
  { "<leader>q",  "<cmd>quit<cr>",                                                                     desc = "quit" },
  -- start group: search
  { "<leader>s",  group = "Search" },
  { "<leader>sC", "<cmd>Telescope find_files search_dirs=app/contracts<cr>",                           desc = "Contracts" },
  { "<leader>sS", "<cmd>Telescope find_files search_dirs=app/services<cr>",                            desc = "Services" },
  { "<leader>sc", "<cmd>Telescope find_files search_dirs=app/controllers<cr>",                         desc = "Controllers" },
  { "<leader>se", "<cmd>Telescope find_files search_dirs=webpack/src/components/elm<cr>",              desc = "Elm" },
  { "<leader>sp", "<cmd>Telescope find_files search_dirs=app/presenters<cr>",                          desc = "Presenters" },
  { "<leader>sr", "<cmd>Telescope find_files search_dirs=app/services<cr>",                            desc = "Services" },
  { "<leader>ss", "<cmd>Telescope find_files search_dirs=spec/<cr>",                                   desc = "Specs" },
  { "<leader>st", "<cmd>Telescope find_files search_dirs=webpack/src/controllers<cr>",                 desc = "Stimulus" },
  { "<leader>sv", "<cmd>Telescope find_files search_dirs=app/views<cr>",                               desc = "Views" },
  { "<leader>sy", "<cmd>Telescope find_files search_dirs=webpack/src/styles<cr>",                      desc = "Styles" },
  -- end group: search
  { "<leader>t",  "<cmd>Neotree toggle position=left<cr>",                                             desc = "tree toggle" },
  { "<leader>v",  function() kiwi.open_wiki_index() end,                                               desc = "Open wiki index" },
  { "<leader>w",  "<cmd>write<cr>",                                                                    desc = "write" },
  { "<leader>x",  "<cmd>quit<cr>",                                                                     desc = "quit" },
  { "<leader>y",  "<cmd>Telescope yaml_schema<cr>",                                                    desc = "Yaml Schema" },
  { "<space>a",   vim.lsp.buf.code_action,                                                             desc = "LSP Code Action" },
  { "<space>e",   helpers.open_on_line,                                                                desc = "Open file on line" },
  { "<space>h",   "<cmd>hide<cr>",                                                                     desc = "Hide" },
  { "<space>n",   "<cmd>only<cr>",                                                                     desc = "Only" },
  { "<space>o",   helpers.toggle_quickfix,                                                             desc = "Toggle quickfix" },
  { "<space>q",   "<cmd>quit<cr>",                                                                     desc = "Quit" },
  { "<space>u",   "<cmd>%s/fit/it<cr>",                                                                desc = "Unfocus test in Ruby" },
  { "<space>w",   "<cmd>write<cr>",                                                                    desc = "Write" },
  { "<space>x",   "<cmd>quit<cr>",                                                                     desc = "Quit" },
  { "<space>y",   "<cmd>%y+<cr>",                                                                      desc = "Copy contents to clipboard" },
  { "H",          git_utils.prev_hunk,                                                                 desc = "Prev hunk" },
  { "T",          kiwi.todo.toggle,                                                                    desc = "Toggle Todo" },
  { "W",          "<cmd>HopWord<cr>",                                                                  desc = "Hop Word",                          mode = "n" },
  { "g",          group = "go to" },
  { "gc",         vim.lsp.buf.declaration,                                                             desc = "[LSP] Go to Declaration" },
  { "gd",         vim.lsp.buf.definition,                                                              desc = "[LSP] Go to Definition" },
  { "gi",         vim.lsp.buf.implementation,                                                          desc = "[LSP] Go to Implementation" },
  { "gr",         vim.lsp.buf.references,                                                              desc = "[LSP] Go to References" },
  { "gt",         vim.lsp.buf.type_definition,                                                         desc = "[LSP] Go to Type Definition" },
  { "h",          git_utils.next_hunk,                                                                 desc = "Next hunk" },
  { "l",          "<cmd>HopLineStart<cr>",                                                             desc = "Hop Line Start",                    mode = { "n", "v" } },
  { "s",          "<cmd>HopChar1<cr>",                                                                 desc = "Hop Char 1",                        mode = { "n", "v" } },
  -- toggle
  { "t",          group = "toggle" },
  { "t0",         function() git_utils.set_base_branch("HEAD", "close") end,                           desc = "Change base: HEAD~1" },
  { "t1",         function() git_utils.set_base_branch("HEAD~1", "focus") end,                         desc = "Change base: HEAD~1" },
  { "t2",         function() git_utils.set_base_branch("HEAD~2", "focus") end,                         desc = "Change base: HEAD~2" },
  { "tb",         "<cmd>Gitsigns toggle_current_line_blame<cr>",                                       desc = "Blame" },
  { "tc",         function() git_utils.set_base_branch(vim.fn.getreg("+"), "focus") end,               desc = "Change base: Clipboard" },
  { "te",         function() git_utils.set_base_branch(os.getenv("GIT_BASE"), "focus") end,            desc = "Change base: From Environment" },
  { "tf",         "<cmd>Neotree float git_status<cr>",                                                 desc = "Float git status" },
  { "th",         "<cmd>Gitsigns toggle_deleted<cr><cmd>Gitsigns toggle_word_diff<cr>",                desc = "Deleted" },
  { "tm",         function() git_utils.set_base_branch("master", "focus") end,                         desc = "Change base: master" },
  { "tn",         "<cmd>Gitsigns diffthis<cr>",                                                        desc = "Diff this" },
  { "tq",         git_utils.hunks_to_loclist,                                                          desc = "Hunks to Loclist" },
}

local noop = {
  { "s", "s", desc = "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
  { "l", "l", desc = "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
}

wk.add(base)
wk.add(noop)

wk.setup({})
