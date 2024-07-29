-- Ansible managed: templates/lua/plugins/mason-nvim-dap.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require("mason-nvim-dap").setup({
    ensure_installed = {
                      "python",
                              "js",
                  },
    automatic_installation = true,
})
