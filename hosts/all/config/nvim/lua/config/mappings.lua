local wk = require("which-key")
local gs = require('gitsigns')
local kiwi = require('kiwi')
local telescope_utils = require('config.telescope_utils')

vim.g.mapleader = ","

vim.keymap.set({ 'n', 'v' }, '<Down>', 'gj')
vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')

vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true, silent = true })

local find_spec = function()
    require'telescope.builtin'.find_files({search_dirs = { "spec/" }, search_file = vim.fn.expand("%:t:r") })
end

local find_template_in_views = function()
    local filename = vim.fn.expand("%:t:r:r"):gsub("^_", "")
    local regex = "(render|partial:)[\\s(]?[\'\"][^\\s]*" .. filename .. "[\'\"]\\B"
    require'telescope.builtin'.grep_string({search_dirs = { "app" }, search = regex, use_regex=true })
end

local file_gh_url_to_clipboard = function()
    local file_name = vim.fn.expand("%")
    local ln = vim.api.nvim_win_get_cursor(0)[1]
	local hash_command = "git log -n 1 --pretty=format:'%H'"
	local repo_command = "git remote -v"

	local handle = io.popen(hash_command)
    if handle == nil then return end

	local hash = handle:read("*a")
	handle:close()

	handle = io.popen(repo_command)
    if handle == nil then return end

	local repo_out = handle:read("*a")
	handle:close()

    local repo = string.gsub(string.match(repo_out, "github%.com.([^ ]+)"), ".git", "")

    local url = "https://github.com/" .. repo .. "/blob/" .. hash .. "/" .. file_name .. "#L" .. ln

    vim.fn.setreg("+", url)
end

local telescope = {
    { "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<A-w>", "<cmd>Telescope grep_string word_match=-w<cr>",desc =  "String Grep" },
    { "<C-e>", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent Files" },
    { "<C-b>", "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>", desc = "Buffers" },
    { "<C-f>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<A-g>", "<cmd>Telescope tags only_sort_tags=false fname_width=60 show_line=false<cr>", desc = "Tags" },
    { "<C-t>", function() require'telescope.builtin'.tags({ fname_width=60, show_line=false, only_sort_tags=true, default_text = vim.fn.expand("<cword>") }) end, desc = "Find tag" },
    { "<C-s>", "<cmd>Telescope current_buffer_tags show_line=true<cr>", desc = "Tags" },
    { "<C-q>", "<cmd>Telescope quickfix show_line=false<cr>", desc = "Quickfix" },
    { "<C-p>", telescope_utils.changed_files, desc = "Search changed files" },
    { "<C-u>", "<cmd>Telescope lsp_references include_declaration=true fname_width=60 show_line=false trim_text=false<cr>", desc = "Ref" },
    { "<leader>y", "<cmd>Telescope yaml_schema<cr>", desc = "Yaml Schema" },
    { "<leader>s", group = "Search" },
    { "<leader>sc", "<cmd>Telescope find_files search_dirs=app/controllers<cr>", desc = "Controllers" },
    { "<leader>sC", "<cmd>Telescope find_files search_dirs=app/contracts<cr>", desc = "Contracts" },
    { "<leader>se", "<cmd>Telescope find_files search_dirs=webpack/src/components/elm<cr>", desc = "Elm" },
    { "<leader>sp", "<cmd>Telescope find_files search_dirs=app/presenters<cr>", desc = "Presenters" },
    { "<leader>sr", "<cmd>Telescope find_files search_dirs=app/services<cr>", desc = "Services" },
    { "<leader>ss", "<cmd>Telescope find_files search_dirs=spec/<cr>", desc = "Specs" },
    { "<leader>sS", "<cmd>Telescope find_files search_dirs=app/services<cr>", desc = "Services" },
    { "<leader>st", "<cmd>Telescope find_files search_dirs=webpack/src/controllers<cr>", desc = "Stimulus" },
    { "<leader>sv", "<cmd>Telescope find_files search_dirs=app/views<cr>", desc = "Views" },
    { "<leader>sy", "<cmd>Telescope find_files search_dirs=webpack/src/styles<cr>", desc = "Styles" },
    { "<A-v>", function() require'telescope.builtin'.find_files({search_dirs = { "app/views" }, search_file = vim.fn.expand("<cword>") }) end, desc = "Views" },
    -- { "<A-s>", find_spec, desc = "Find Spec" },
    { "<A-b>", file_gh_url_to_clipboard, desc = "Copy gh url" },
    { "<A-s>", "<cmd>A<cr>", desc = "Find Spec" },
    { "<A-g>", telescope_utils.git_commits, desc = "Find template in views" },
    { "<A-t>", find_template_in_views, desc = "Find template in views" },
    { "<leader>gy", "<cmd>Telescope grep_string search_dirs=webpack/src/styles<cr>", desc = "Grep Styles" }
}

local toggle_quickfix = function()
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            vim.cmd "cclose"
            return
        else
            vim.cmd "copen"
        end
    end
end

local open_on_line = function()
    local str = vim.fn.getreg("+")

    if str then
        local pattern = ":(%d+)"
        local path = str:match("(%.?[%a%/%_]+%.[%a%._-]+)")
        local ln = str:match(pattern)
        local cmd
        if ln then
            cmd = string.format("e +%s %s", ln, path)
        else
            cmd = 'e ' .. path
        end
        vim.cmd(cmd)
    end
end

local hunks_to_loclist = function()
    gs.setqflist("attached", { use_location_list = true, open = true })
end

local toggle_git_status = function(action, toggle, float, position, git_base)
    if git_base == nil then
        git_base = vim.g.git_base
    end

    require('neo-tree.command').execute({
        action = action,
        position = position,
        toggle = toggle,
        float = float,
        source = "git_status",
        git_base = git_base
    })
end

local set_base_branch = function(git_base, action)
    if git_base == nil then
        git_base = vim.g.git_base
    -- elseif git_base == vim.g.git_base then
    --     git_base = "HEAD"
    --     vim.g.git_base = git_base
    else
        vim.g.git_base = git_base
    end

    gs.change_base(git_base, true)

    toggle_git_status(action, false, true, "float", git_base)
end

local toggle = {
    {"<leader>h", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Deleted" },
    { "t", group = "toggle" },
    { "th", "<cmd>Gitsigns toggle_deleted<cr><cmd>Gitsigns toggle_word_diff<cr>", desc = "Deleted" },
    { "tn", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
    { "tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame" },
    { "tf", "<cmd>Neotree float git_status<cr>", desc = "Float git status" },
    { "tq", hunks_to_loclist, desc = "Hunks to Loclist" },
    { "tm", function() set_base_branch("master", "focus") end, desc = "Change base: master" },
    { "t0", function() set_base_branch("HEAD", "close") end, desc = "Change base: HEAD~1" },
    { "t1", function() set_base_branch("HEAD~1", "focus") end, desc = "Change base: HEAD~1" },
    { "t2", function() set_base_branch("HEAD~2", "focus") end, desc = "Change base: HEAD~2" },
    { "tc", function() set_base_branch(vim.fn.getreg("+"), "focus") end, desc = "Change base: Clipboard" },
    { "te", function() set_base_branch(os.getenv("GIT_BASE"), "focus") end, desc = "Change base: From Environment" }
}

local git = {
    { "h", function() gs.nav_hunk("next", { preview = false, wrap = true }) end, desc = "Next hunk" },
    { "H", function() gs.nav_hunk("prev", { preview = false, wrap = true }) end, desc = "Prev hunk" },
    { "<leader>d", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" }
}

local file = {
    { "<leader>c", "<cmd>let @+=expand('%')<cr>", desc = "copy current filepath to clipboard" },
    { "<leader>q", "<cmd>quit<cr>", desc = "quit" },
    { "<leader>t", "<cmd>Neotree toggle position=left<cr>", desc = "tree toggle" },
    { "<leader>n", function() toggle_git_status("focus", true, false, "right", nil) end, desc = "Tree: Git status" },
    { "<leader>m", function() toggle_git_status("focus", true, false, "right", "master") end, desc = "Change base: master" },
    { "<leader>w", "<cmd>write<cr>", desc = "write" },
    { "<leader>x", "<cmd>quit<cr>", desc = "quit" },
    { "<space>e", open_on_line, desc = "Open file on line" },
    { "<space>o", toggle_quickfix, desc = "Toggle quickfix" },
    { "<space>h", "<cmd>hide<cr>", desc = "Hide" },
    { "<space>n", "<cmd>only<cr>", desc = "Only" },
    { "<space>q", "<cmd>quit<cr>", desc = "Quit" },
    { "<space>w", "<cmd>write<cr>", desc = "Write" },
    { "<space>x", "<cmd>quit<cr>", desc = "Quit" },
    { "<space>y", "<cmd>%y+<cr>", desc = "Copy contents to clipboard" },
    { "<space>u", "<cmd>%s/fit/it<cr>", desc = "Unfocus test in Ruby" },
}

local lsp = {
    { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP Signature help" },
    { "<C-h>", vim.lsp.buf.hover, desc = "LSP Hover" },
    { "<C-d>", vim.lsp.buf.definition, desc = "[LSP] Go to Definition" },
    { "<C-f>", function() vim.lsp.buf.format { async = true } end, desc = "LSP Format", mode = "i" },
    { "<space>a", vim.lsp.buf.code_action, desc = "LSP Code Action" },
    { "<leader>f", function() vim.lsp.buf.format { async = true } end, desc = "LSP Format" },
    -- c = {
    --     name = "+code",
    --     a = { vim.lsp.buf.code_action, desc = "LSP Code Action" },
    --     r = { vim.lsp.buf.rename, desc = "LSP Rename" },
    -- },
    -- g = {
    --     name = "+go to",
    --     c = { vim.lsp.buf.declaration, desc = "Go to Declaration" },
    --     d = { vim.lsp.buf.definition, desc = "Go to Definition" },
    --     i = { vim.lsp.buf.implementation, desc = "Go to Implementation" },
    --     r = { vim.lsp.buf.references, desc = "Go to References" },
    --     t = { vim.lsp.buf.type_definition, desc = "Go to Type Definition" },
    -- },
    -- Q = { "<cmd>LspRestart<cr>", desc = "LSP Restart" },
    { "g", group = "go to" },
    { "gc", vim.lsp.buf.declaration, desc = "[LSP] Go to Declaration" },
    { "gd", vim.lsp.buf.definition, desc = "[LSP] Go to Definition" },
    { "gi", vim.lsp.buf.implementation, desc = "[LSP] Go to Implementation" },
    { "gr", vim.lsp.buf.references, desc = "[LSP] Go to References" },
    { "gt", vim.lsp.buf.type_definition, desc = "[LSP] Go to Type Definition" },
}

local diagnostics = {
    { "<C-d>", vim.diagnostic.goto_next, desc = "Diagnostics Next" },
    -- ["<leader>"] = {
    --     e = {
    --         name = "+diagnostics",
    --         e = { vim.diagnostic.goto_next, desc = "Diagnostics Next" },
    --         u = { vim.diagnostic.goto_prev, desc = "Diagnostics Prev" },
    --         f = { vim.diagnostic.open_float, desc = "Diagnostics Float" },
    --     }
    -- }
}

local tabs = {
    { "<A-,>", "<cmd>BufferPrevious<cr>", desc = "Previous Buffer" },
    { "<A-.>", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
    { "<A-<>", "<cmd>BufferMovePrevious<cr>", desc = "Move Previous Buffer" },
    { "<A->>", "<cmd>BufferMoveNext<cr>", desc = "Move Next Buffer" },
    { "<A-c>", "<cmd>BufferClose<cr>", desc = "Close Buffer" },
    { "<A-p>", "<cmd>BufferPin<cr>", desc = "Pin Buffer" },
    { "<A-q>", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close Buffer All But Current" },
    { "<A-x>", "<cmd>BufferCloseAllButPinned<cr>", desc = "Close Buffer All But Pinned" },
    { "<A-h>", "<cmd>BufferFirst<cr>", desc = "Go to First" },
    { "<A-/>", "<cmd>BufferPrevious<cr>", desc = "Go to Previous" },
}

local floaterm = {
    { "<A-t>", "<Cmd>FloatermToggle first<CR>", desc = "Toggle first terminal" },
    { "<Esc>", "<C-\\><C-n>:q<CR>", desc = "Close floatterm", mode = "t" }
}

local hop = {
    { "s", "<cmd>HopChar1<cr>", desc = "Hop Char 1", mode = { "n", "v" } },
    { "W", "<cmd>HopWord<cr>", desc = "Hop Word", mode = "n" },
    { "l", "<cmd>HopLineStart<cr>", desc = "Hop Line Start", mode = { "n", "v" } }
}

local builtin = {
    { "<A-z>", "za", desc ="Toggle Fold" },
    { "<A-m>", "zMzA", desc ="Toggle Fold" },
    { "<A-l>", "<cmd>set cursorline!<cr>", desc ="Toggle Cursorline" },
}

-- local dap = {
--     ["<leader>"] = {
--         d = {
--             name = "+DAP",
--             c = { "<cmd>DapContinue<cr>", "Continue" },
--             d = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
--             t = { "<cmd>DapTerminate<cr>", "Terminate" },
--             s = { "<cmd>DapStepOver<cr>", "Step Over" },
--         }
--     }
-- }

local noop = {
    { "s", "s", desc = "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
    { "l", "l", desc = "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
}

vim.g.codeium_no_map_tab = 1

-- local codeium = {
--     ["<C-u>"] = { function() return vim.fn['codeium#Accept']() end, "Codeium Accept", mode = "i", expr = true },
--     ["<C-l>"] = { function() return vim.fn['codeium#CycleCompletions'](-1) end, "Codeium Accept", mode = "i", expr = true },
--     ["<C-y>"] = { function() return vim.fn['codeium#CycleCompletions'](1) end, "Codeium Accept", mode = "i", expr = true },
--     ["<leader>"] = {
--         a = {
--             name = "+assistant",
--             d = { "<cmd>CodeiumEnable<cr>", "Codeium Enable" },
--             D = { "<cmd>CodeiumDisable<cr>", "Codeium Disable" },
--         }
--     }
-- }

local utils = {
    {"<F4>", "<C-R>=strftime('%T')<cr>", desc = "Insert time", mode = "i" },
    {"<F5>", "<C-R>=strftime('%Y-%m-%d %a')<cr>", desc = "Insert date with weekday", mode = "i" },
    {"<F6>", "<C-R>=strftime('%F')<cr>", desc = "Insert date", mode = "i" },
    {"<F8>", "<C-R>=expand('%:t')<cr>", desc = "Insert current filename", mode = "i" },
    {"<leader>v", function() kiwi.open_wiki_index() end, desc = "Open wiki index" },
    { "T", kiwi.todo.toggle, desc = "Toggle Todo" }
}

local capslock = {
    "<A-n>", "<Plug>CapsLockToggle", desc = "Toggle Capslock", mode = "i"
}

vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')
--vim.keymap.set('n', '<leader>ga', "<cmd>Telescope grep_string word_match=-w search_dirs=input('Dir: ')<cr>")
vim.keymap.set('n', '<leader>ga', ":Telescope grep_string search_dirs=")


wk.add(capslock)
wk.add(utils)
wk.add(file)
wk.add(telescope)
wk.add(lsp)
wk.add(diagnostics)
wk.add(tabs)
--wk.add(floaterm)
wk.add(hop)
wk.add(builtin)
wk.add(git)
wk.add(toggle)
wk.add(noop)

wk.setup({})
