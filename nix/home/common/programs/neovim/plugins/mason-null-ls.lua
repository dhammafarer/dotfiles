-- Ansible managed: templates/lua/plugins/mason-null-ls.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

require("mason-null-ls").setup {
    ensure_installed = {
        "golines",
        "sql-formatter",
    },
    automatic_installation = true,
}
