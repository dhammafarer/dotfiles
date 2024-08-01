local wk = require("which-key")
local gs = require('gitsigns')
local kiwi = require('kiwi')


vim.g.mapleader = ","

vim.keymap.set({ 'n', 'v' }, '<Down>', 'gj')
vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')

vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true, silent = true })

local telescope = {
    { "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<A-s>", "<cmd>Telescope grep_string<cr>",desc =  "String Grep" },
    { "<C-e>", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent Files" },
    { "<C-b>", "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>", desc = "Buffers" },
    { "<C-f>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<C-t>", "<cmd>Telescope tags only_sort_tags=false fname_width=60 show_line=false<cr>", desc = "Tags" },
    { "<C-s>", "<cmd>Telescope current_buffer_tags show_line=true<cr>", desc = "Tags" },
    { "<C-q>", "<cmd>Telescope quickfix show_line=false<cr>", desc = "Quickfix" },
    { "<C-h>", "<cmd>Telescope quickfixhistory<cr>", desc = "Quickfix" },
    { "<C-u>", "<cmd>Telescope lsp_references include_declaration=true fname_width=60 show_line=false trim_text=false<cr>", desc = "Ref" },
    { "<leader>y", "<cmd>Telescope yaml_schema<cr>", desc = "Yaml Schema" }
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
        local path = str:match("(%.?[%a%/%_]+%.[%a%.]+)")
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
    elseif git_base == vim.g.git_base then
        git_base = "HEAD"
        vim.g.git_base = git_base
    else
        vim.g.git_base = git_base
    end

    gs.change_base(git_base, true)
    gs.toggle_deleted(true)

    toggle_git_status(action, false, false, "right", git_base)
end

local toggle = {
    {"<leader>h", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Deleted" },
    { "t", group = "toggle" },
    { "th", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Deleted" },
    { "td", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Deleted" },
    { "tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame" },
    { "tf", "<cmd>Neotree float git_status<cr>", desc = "Float git status" },
    { "tq", hunks_to_loclist, desc = "Hunks to Loclist" },
    { "tm", function() set_base_branch("master", "show") end, desc = "Change base: master" },
    { "t0", function() set_base_branch("HEAD", "close") end, desc = "Change base: HEAD~1" },
    { "t1", function() set_base_branch("HEAD~1", "show") end, desc = "Change base: HEAD~1" },
    { "t2", function() set_base_branch("HEAD~2", "show") end, desc = "Change base: HEAD~2" },
    { "tc", function() set_base_branch(vim.fn.getreg("+"), "show") end, desc = "Change base: Clipboard" },
    { "te", function() set_base_branch(os.getenv("GIT_BASE"), "show") end, desc = "Change base: From Environment" }
}

local git = {
    { "h", function() gs.nav_hunk("next", { preview = false, wrap = true }) end, desc = "Next hunk" },
    { "H", function() gs.nav_hunk("prev", { preview = false, wrap = true }) end, desc = "Prev hunk" },
    { "<leader>d", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" }
}

local file = {
    {"<leader>c", "<cmd>let @+=expand('%')<cr>", desc = "copy current filepath to clipboard" },
    {"<leader>q", "<cmd>quit<cr>", desc = "quit" },
    {"<leader>t", "<cmd>Neotree toggle position=left<cr>", desc = "tree toggle" },
    {"<leader>n", function() toggle_git_status("focus", true, false, "right", nil) end, desc = "Tree: Git status" },
    {"<leader>m", function() toggle_git_status("focus", true, false, "right", "master") end, desc = "Change base: master" },
    {"<leader>w", "<cmd>write<cr>", desc = "write" },
    {"<leader>x", "<cmd>quit<cr>", desc = "quit" },
    {"<space>e", open_on_line, desc = "Open file on line" },
    {"<space>h", "<cmd>hide<cr>", desc = "Hide" },
    {"<space>o", "<cmd>only<cr>", desc = "Only" },
    {"<space>n", toggle_quickfix, desc = "Toggle quickfix" },
    {"<space>q", "<cmd>quit<cr>", desc = "Quit" },
    {"<space>w", "<cmd>write<cr>", desc = "Write" },
    {"<space>x", "<cmd>quit<cr>", desc = "Quit" },
    {"<space>y", "<cmd>%y+<cr>", desc = "Copy contents to clipboard" }
}

local lsp = {
    { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP Signature help" },
    { "<C-space>", vim.lsp.buf.hover, desc = "LSP Hover" },
    { "<C-d>", vim.lsp.buf.definition, desc = "[LSP] Go to Definition" },
    { "<C-f>", function() vim.lsp.buf.format { async = true } end, desc = "LSP Format", mode = "i" },
    { "<space>a", vim.lsp.buf.code_action, desc = "LSP Code Action" },
    { "f", function() vim.lsp.buf.format { async = true } end, desc = "LSP Format" },
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
    { "s", "<cmd>HopChar1<cr>", desc = "Hop Char 1", mode = "n" },
    { "W", "<cmd>HopWord<cr>", desc = "Hop Word", mode = "n" },
    { "l", "<cmd>HopLineStart<cr>", desc = "Hop Line Start", mode = { "n", "v" } },
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

wk.add(capslock)
wk.add(utils)
wk.add(file)
wk.add(telescope)
wk.add(lsp)
wk.add(diagnostics)
wk.add(tabs)
wk.add(floaterm)
wk.add(hop)
wk.add(builtin)
wk.add(git)
wk.add(toggle)
wk.add(noop)

wk.setup({})
