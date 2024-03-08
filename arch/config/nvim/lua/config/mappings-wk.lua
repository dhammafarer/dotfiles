local wk = require("which-key")
local kiwi = require('kiwi')

vim.g.mapleader = ","

local telescope = {
    ["<A-f>"] = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    ["<A-s>"] = { "<cmd>Telescope yaml_schema<cr>", "Yaml Schema" },
    ["<C-e>"] = { "<cmd>Telescope oldfiles cwd_only=true<cr>", "Recent Files" },
    ["<C-f>"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<C-t>"] = { "<cmd>Telescope tags only_sort_tags=true<cr>", "Tags" },
    ["<leader>"] = {
        f = {
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            w = { "<cmd>Telescope find_files cwd=/home/pl/Nextcloud/Notes<cr>", "Search files in wiki" },
            t = { "<cmd>Telescope live_grep cwd=/home/pl/Nextcloud/Notes<cr>", "Search text in wiki" },
            g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
            h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
            m = { "<cmd>Telescope marks<cr>", "Marks" },
            r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        },
    }
}

local file = {
    ["<leader>"] = {
        f = {
            name = "+file",
            n = { "<cmd>enew<cr>", "New File" },
        },
        n = { "<cmd>NvimTreeToggle<cr>", "Tree Toggle" },
        x = { "<cmd>quit<cr>", "Quit" },
        q = { "<cmd>quit<cr>", "Quit" },
        w = { "<cmd>write<cr>", "Write" },
    },
    ["<space>"] = {
        w = { "<cmd>write<cr>", "Write" },
        q = { "<cmd>quit<cr>", "Quit" },
        x = { "<cmd>quit<cr>", "Quit" },
        n = { "<cmd>NvimTreeToggle<cr>", "Tree Toggle" },
        y = { "<cmd>%y+<cr>", "Coppy contents to clipboard" },
    }
}

local lsp = {
    ["<A-s>"] = { "<cmd>set ft=yaml<cr><cmd>Telescope yaml_schema<cr>", "Yaml Schema" },
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
    ["<C-h>"] = { vim.diagnostic.goto_next, "Diagnostics Next" },
    ["<leader>"] = {
        e = {
            name = "+diagnostics",
            e = { vim.diagnostic.goto_next, "Diagnostics Next" },
            u = { vim.diagnostic.goto_prev, "Diagnostics Prev" },
            f = { vim.diagnostic.open_float, "Diagnostics Float" },
            l = { vim.diagnostic.setloclist, "Diagnostics List" },
        }
    }
}

local tabs = {
    ["<A-,>"] = { "<cmd>BufferPrevious<cr>", "Previous Buffer" },
    ["<A-.>"] = { "<cmd>BufferNext<cr>", "Next Buffer" },
    ["<A-c>"] = { "<cmd>BufferClose<cr>", "Close Buffer" },
    ["<A-x>"] = { "<cmd>BufferCloseAllButCurrent<cr>", "Close Buffer All But Current" },
    ["<A-p>"] = { "<cmd>BufferPin<cr>", "Pin Buffer" },
}

local floaterm = {
    t = { "<Cmd>FloatermToggle first<CR>", "Toggle first terminal" },
    ["<A-t>"] = { "<Cmd>FloatermToggle second<CR>", "Toggle second terminal" },
    ["<Esc>"] = { "<C-\\><C-n>:q<CR>", "Close floatterm", mode = "t" }
}

local hop = {
    s = { "<cmd>HopChar1<cr>", "Hop Char 1", mode = "n" },
    W = { "<cmd>HopWord<cr>", "Hop Word", mode = "n" },
    l = { "<cmd>HopLineStart<cr>", "Hop Line Start", mode = { "n", "v" } },
}

local builtin = {
    ["<leader>"] = {
        m = { "<cmd>Man \"<cword>\"<cr>", "Look up Man Pages" }
    },
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
    ["<C-h>"] = { "<cmd>CodeiumDisable<cr>", "Codeium Disable", mode = "i" },
    ["<C-k>"] = { "<cmd>CodeiumEnable<cr>", "Codeium Enable", mode = "i" },
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
    ["<F5>"] = { "<C-R>=strftime('%F')<cr>", "Insert date", mode = "i" },
    ["<F6>"] = { "<C-R>=strftime('%a, %d %b %Y')<cr>", "Insert pretty date", mode = "i" },
    ["<leader>"] = {
        a = {
            name = "+assistant",
            a = { "<cmd>ChatGPT<cr>", "GPT Chat" },
            e = { "<cmd>ChatGPTEditWithInstructions<cr>", "GPT Edit" },
        },
        v = { kiwi.open_wiki_index, "Open wiki index"},
        o = {
            name = "+ollama",
            o = { "<cmd>lua require('ollama').prompt()<cr>", "ollama prompt", mode = {"n", "v"} },
            g = { "<cmd>lua require('ollama').prompt('Generate_Code')<cr>", "generate code", mode = {"n", "v"} },
             
        }
    },
    T = { kiwi.todo.toggle, "Toggle Todo"},
}

local capslock = {
    ["<A-n>"] = { "<Plug>CapsLockToggle", "Toggle Capslock", mode = "i" }
}

wk.register(capslock)
wk.register(utils)
wk.register(file)
wk.register(telescope)
wk.register(lsp)
wk.register(dap)
wk.register(diagnostics)
wk.register(tabs)
wk.register(floaterm)
wk.register(hop)
wk.register(builtin)
--wk.register(codeium)
wk.register(noop)

wk.setup({})
