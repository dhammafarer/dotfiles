-- Ansible managed: templates/lua/plugins/nightfox.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require('nightfox').setup({
  options = {
      transparent = true,
      dim_inactive = false,
  },
})

vim.cmd("colorscheme nordfox")
