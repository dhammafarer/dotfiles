local wk = require("which-key")
local gs = require('gitsigns')
local kiwi = require('kiwi')


vim.g.mapleader = ","

vim.keymap.set({ 'n', 'v' }, '<Down>', 'gj')
vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')

vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true, silent = true })

local telescope = {
    ["<A-f>"] = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    ["<A-s>"] = { "<cmd>Telescope grep_string<cr>", "String Grep" },
    ["<C-e>"] = { "<cmd>Telescope oldfiles cwd_only=true<cr>", "Recent Files" },
    ["<C-b>"] = { "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>", "Buffers" },
    ["<C-f>"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<C-t>"] = { "<cmd>Telescope tags only_sort_tags=false fname_width=60 show_line=false<cr>", "Tags" },
    ["<C-s>"] = { "<cmd>Telescope current_buffer_tags show_line=true<cr>", "Tags" },
    ["<C-q>"] = { "<cmd>Telescope quickfix show_line=false<cr>", "Quickfix" },
    ["<C-h>"] = { "<cmd>Telescope quickfixhistory<cr>", "Quickfix" },
    -- ["<C-u>"] = { "<cmd>Telescope loclist show_line=true fname_width=60<cr>", "Loclist" },
    ["<C-u>"] = { "<cmd>Telescope lsp_references include_declaration=true fname_width=60 show_line=false trim_text=false<cr>", "Loclist" },
    ["<leader>"] = {
        f = {
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
            m = { "<cmd>Telescope marks<cr>", "Marks" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
            s = { "<cmd>Telescope grep_string<cr>", "Live Grep" },
            t = { "<cmd>Telescope live_grep cwd=/home/pl/Nextcloud/Notes<cr>", "Search text in wiki" },
            w = { "<cmd>Telescope find_files cwd=/home/pl/Nextcloud/Notes<cr>", "Search files in wiki" },
            y = { "<cmd>Telescope yaml_schema<cr>", "Yaml Schema" },
        },
    }
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

local toggle_git_status = function(action, toggle, git_base)
    if git_base == nil then
        git_base = vim.g.git_base
    end

    require('neo-tree.command').execute({
        action = action,
        position = "right",
        toggle = toggle,
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

    toggle_git_status(action, false, git_base)
end

local toggle = {
    ["<leader>"] = {
        h = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
    },
    t = {
        name = "+toggle",
        h = { "<cmd>Gitsigns toggle_deleted<cr>", "Deleted" },
        b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame" },
        q = { hunks_to_loclist, "Hunks to Loclist" },
        ["m"] = { function() set_base_branch("master", "show") end, "Change base: master" },
        ["0"] = { function() set_base_branch("HEAD", "close") end, "Change base: HEAD~1" },
        ["1"] = { function() set_base_branch("HEAD~1", "show") end, "Change base: HEAD~1" },
        ["2"] = { function() set_base_branch("HEAD~2", "show") end, "Change base: HEAD~2" },
        ["c"] = { function() set_base_branch(vim.fn.getreg("+"), "show") end, "Change base: Clipboard" },
    }
}

local git = {
    h = { function() gs.nav_hunk("next", { preview = false, wrap = true }) end, "Next hunk" },
    H = { function() gs.nav_hunk("prev", { preview = false, wrap = true }) end, "Prev hunk" },
    ["<leader>"] = {
        d = { "<cmd>Gitsigns diffthis<cr>", "Diff this" },
    },
}

local file = {
    ["<leader>"] = {
        f = {
            name = "+file",
            n = { "<cmd>enew<cr>", "New File" },
        },
        c = { "<cmd>let @+=expand('%')<cr>", "copy current filepath to clipboard" },
        q = { "<cmd>quit<cr>", "quit" },
        t = { "<cmd>Neotree toggle position=left<cr>", "tree toggle" },
        n = { function() toggle_git_status("focus", true, nil) end, "Tree: Git status" },
        m = { function() toggle_git_status("focus", true, "master") end, "Change base: master" },
        w = { "<cmd>write<cr>", "write" },
        x = { "<cmd>quit<cr>", "quit" },
    },
    -- ["<C-b>"] = { "<cmd>Neotree float buffers<cr>", "Buffers" },
    ["<space>"] = {
        e = { open_on_line, "Open file on line" },
        h = { "<cmd>hide<cr>", "Hide" },
        o = { "<cmd>only<cr>", "Only" },
        n = { toggle_quickfix, "Toggle quickfix" },
        q = { "<cmd>quit<cr>", "Quit" },
        w = { "<cmd>write<cr>", "Write" },
        x = { "<cmd>quit<cr>", "Quit" },
        y = { "<cmd>%y+<cr>", "Copy contents to clipboard" },
    },
}

local lsp = {
    ["<C-k>"] = { vim.lsp.buf.signature_help, "LSP Signature help" },
    ["<C-space>"] = { vim.lsp.buf.hover, "LSP Hover" },
    ["<C-d>"] = { vim.lsp.buf.definition, "[LSP] Go to Definition" },
    ["<C-f>"] = { function() vim.lsp.buf.format { async = true } end, "LSP Format", mode = "i" },
    ["<space>"] = {
        a = { vim.lsp.buf.code_action, "LSP Code Action" },
        c = {
            name = "+code",
            a = { vim.lsp.buf.code_action, "LSP Code Action" },
            r = { vim.lsp.buf.rename, "LSP Rename" },
        },
        f = { function() vim.lsp.buf.format { async = true } end, "LSP Format" },
        g = {
            name = "+go to",
            c = { vim.lsp.buf.declaration, "Go to Declaration" },
            d = { vim.lsp.buf.definition, "Go to Definition" },
            i = { vim.lsp.buf.implementation, "Go to Implementation" },
            r = { vim.lsp.buf.references, "Go to References" },
            t = { vim.lsp.buf.type_definition, "Go to Type Definition" },
        },
        Q = { "<cmd>LspRestart<cr>", "LSP Restart" },
    },
    g = {
        name = "+go to",
        c = { vim.lsp.buf.declaration, "[LSP] Go to Declaration" },
        d = { vim.lsp.buf.definition, "[LSP] Go to Definition" },
        i = { vim.lsp.buf.implementation, "[LSP] Go to Implementation" },
        r = { vim.lsp.buf.references, "[LSP] Go to References" },
        t = { vim.lsp.buf.type_definition, "[LSP] Go to Type Definition" },
    }
}

local diagnostics = {
    ["<C-d>"] = { vim.diagnostic.goto_next, "Diagnostics Next" },
    ["<leader>"] = {
        e = {
            name = "+diagnostics",
            e = { vim.diagnostic.goto_next, "Diagnostics Next" },
            u = { vim.diagnostic.goto_prev, "Diagnostics Prev" },
            f = { vim.diagnostic.open_float, "Diagnostics Float" },
        }
    }
}

local tabs = {
    ["<A-,>"] = { "<cmd>BufferPrevious<cr>", "Previous Buffer" },
    ["<A-.>"] = { "<cmd>BufferNext<cr>", "Next Buffer" },
    ["<A-<>"] = { "<cmd>BufferMovePrevious<cr>", "Move Previous Buffer" },
    ["<A->>"] = { "<cmd>BufferMoveNext<cr>", "Move Next Buffer" },
    ["<A-c>"] = { "<cmd>BufferClose<cr>", "Close Buffer" },
    ["<A-p>"] = { "<cmd>BufferPin<cr>", "Pin Buffer" },
    ["<A-q>"] = { "<cmd>BufferCloseAllButCurrent<cr>", "Close Buffer All But Current" },
    ["<A-x>"] = { "<cmd>BufferCloseAllButPinned<cr>", "Close Buffer All But Pinned" },
    ["<A-h>"] = { "<cmd>BufferFirst<cr>", "Go to First" },
    ["<A-/>"] = { "<cmd>BufferPrevious<cr>", "Go to Previous" },
}

local floaterm = {
    ["<A-t>"] = { "<Cmd>FloatermToggle first<CR>", "Toggle first terminal" },
    ["<Esc>"] = { "<C-\\><C-n>:q<CR>", "Close floatterm", mode = "t" }
}

local hop = {
    s = { "<cmd>HopChar1<cr>", "Hop Char 1", mode = "n" },
    W = { "<cmd>HopWord<cr>", "Hop Word", mode = "n" },
    l = { "<cmd>HopLineStart<cr>", "Hop Line Start", mode = { "n", "v" } },
}

local builtin = {
    -- ["<leader>"] = {
    --     m = { "<cmd>Man \"<cword>\"<cr>", "Look up Man Pages" }
    -- },
    ["<A-z>"] = { "za", "Toggle Fold" },
    ["<A-m>"] = { "zMzA", "Toggle Fold" },
    ["<A-l>"] = { "<cmd>set cursorline!<cr>", "Toggle Cursorline" },
}

local dap = {
    ["<leader>"] = {
        d = {
            name = "+DAP",
            c = { "<cmd>DapContinue<cr>", "Continue" },
            d = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
            t = { "<cmd>DapTerminate<cr>", "Terminate" },
            s = { "<cmd>DapStepOver<cr>", "Step Over" },
        }
    }
}

local noop = {
    s = { "s", "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
    l = { "l", "No Op", mode = "s" }, -- prevent changing mode in snippet expansion
}

vim.g.codeium_no_map_tab = 1

local codeium = {
    ["<C-u>"] = { function() return vim.fn['codeium#Accept']() end, "Codeium Accept", mode = "i", expr = true },
    ["<C-l>"] = { function() return vim.fn['codeium#CycleCompletions'](-1) end, "Codeium Accept", mode = "i", expr = true },
    ["<C-y>"] = { function() return vim.fn['codeium#CycleCompletions'](1) end, "Codeium Accept", mode = "i", expr = true },
    ["<leader>"] = {
        a = {
            name = "+assistant",
            d = { "<cmd>CodeiumEnable<cr>", "Codeium Enable" },
            D = { "<cmd>CodeiumDisable<cr>", "Codeium Disable" },
        }
    }
}

local utils = {
    ["<F4>"] = { "<C-R>=strftime('%T')<cr>", "Insert time", mode = "i" },
    ["<F5>"] = { "<C-R>=strftime('%Y-%m-%d %a')<cr>", "Insert date with weekday", mode = "i" },
    ["<F6>"] = { "<C-R>=strftime('%F')<cr>", "Insert date", mode = "i" },
    ["<F8>"] = { "<C-R>=expand('%:t')<cr>", "Insert current filename", mode = "i" },
    ["<leader>"] = {
        a = {
            name = "+assistant",
            a = { "<cmd>ChatGPT<cr>", "GPT Chat" },
            e = { "<cmd>ChatGPTEditWithInstructions<cr>", "GPT Edit" },
        },
        v = { function() kiwi.open_wiki_index() end, "Open wiki index" },
        -- t = {
        --     name = "+ollama",
        --     a = { ":<c-u>Ollama Ask<cr>", "Ask", mode = {"n", "v"} },
        --     t = { ":<c-u>lua require('ollama').prompt()<cr>", "ollama prompt", mode = {"n", "v"} },
        --     s = { ":<c-u>Ollama Summarize<cr>", "Summarize", mode = {"n", "v"} },
        -- },
        g = {
            name = "+Gen",
            g = { ":Gen<CR>", "Run", mode = { "n", "v" } },
        }
    },
    T = { kiwi.todo.toggle, "Toggle Todo" },
}

local capslock = {
    ["<A-n>"] = { "<Plug>CapsLockToggle", "Toggle Capslock", mode = "i" }
}

wk.register(capslock)
wk.register(utils)
wk.register(file)
wk.register(telescope)
wk.register(lsp)
--wk.register(dap)
wk.register(diagnostics)
wk.register(tabs)
wk.register(floaterm)
wk.register(hop)
wk.register(builtin)
wk.register(codeium)
wk.register(git)
wk.register(toggle)
wk.register(noop)

wk.setup({})
