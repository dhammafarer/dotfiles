-- Ansible managed: templates/lua/plugins/nvim-tree.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require('nvim-tree').setup {
    diagnostics = {
        enable = true,
    },
    view = {
        width = 45,
    },
}
