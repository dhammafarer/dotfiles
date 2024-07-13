-- Ansible managed: templates/lua/plugins/telescope.lua.j2 modified on 2024-05-30 03:10:13 by pl on dev.pale.paradise-liberty.ts.net
local telescope = require("telescope")
local actions = require("telescope.actions")
 local action_state = require "telescope.actions.state"

telescope.setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    },
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            height = 0.95,
        },
    },
    pickers = {
        quickfixhistory = {
             mappings = {
               i = {
                 ["<CR>"] = function(prompt_buf)
                   local entry = action_state.get_selected_entry()
                   actions.close(prompt_buf)
                   vim.cmd("Telescope quickfix fname_width=60 show_line=true nr=" .. entry.nr)
                 end
               }
             }
        }
    }
}

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
