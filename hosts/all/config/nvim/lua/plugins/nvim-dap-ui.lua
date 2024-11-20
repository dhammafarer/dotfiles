-- Ansible managed: templates/lua/plugins/nvim-dap-ui.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
