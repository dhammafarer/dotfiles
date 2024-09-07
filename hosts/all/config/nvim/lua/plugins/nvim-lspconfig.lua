-- Ansible managed: templates/lua/plugins/nvim-lspconfig.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

lspconfig["ansiblels"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["astro"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["elmls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["eslint"].setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["gopls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["lua_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["pyright"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["rust_analyzer"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["solargraph"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["tailwindcss"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["ts_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["volar"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
lspconfig["yamlls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}
