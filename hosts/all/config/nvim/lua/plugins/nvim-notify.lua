-- Ansible managed: templates/lua/plugins/nvim-notify.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require'notify'.setup({
    background_colour = "#192330",
    --max_width = 50,
    --max_height = 5,
    top_down  = false,
    render = "compact"
})
