-- Ansible managed: templates/lua/plugins/rust-tools.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      require("which-key").register({
        ["<C-space>"] = { rt.hover_actions.hover_actions, "Hover Actions" }, { buffer = bufnr },
        ["<leader>a"] = { rt.code_action_group.code_action_group, "Code Action Group" }, { buffer = bufnr },
      })
    end,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
})
