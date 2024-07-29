-- Ansible managed: templates/lua/plugins/telescope.lua.j2 modified on 2024-05-30 03:10:13 by pl on dev.pale.paradise-liberty.ts.net
require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    },
    defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                height = 0.9,
                mirror = true,
                prompt_position = "top",
                preview_cutoff = 0,
                preview_height = 0.5,
                width = 0.8
            }
        }
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
