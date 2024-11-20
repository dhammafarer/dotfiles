-- Ansible managed: templates/lua/plugins/mason-lspconfig.lua.j2 modified on 2024-05-30 03:10:13 by pl on dev.pale.paradise-liberty.ts.net

require("mason-lspconfig").setup {
    ensure_installed = {
        "ansiblels",
        "astro",
        "clangd",
        "elmls",
        "eslint",
        "gopls",
        "lua_ls",
        "pyright",
        "tailwindcss",
        "volar",
        "yamlls",
    },
    automatic_installation = false,
}
