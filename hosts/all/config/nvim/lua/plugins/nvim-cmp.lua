-- Ansible managed: templates/lua/plugins/nvim-cmp.lua.j2 modified on 2024-06-28 12:48:02 by pl on dev.pale.paradise-liberty.ts.net
-- luasnip setup
local luasnip = require 'luasnip'

-- lspkind setup
local lspkind = require('lspkind')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.config.disable,
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        ['<C-h>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
        ['<C-n>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        {
            name = "nvim_lsp",
            entry_filter = function(entry)
                return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end
        },
        { name = 'luasnip' },
        { name = 'codeium' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(_, vim_item)
                return vim_item
            end
        })
    },
}
