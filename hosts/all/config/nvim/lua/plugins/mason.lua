-- Ansible managed: templates/lua/plugins/mason.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
