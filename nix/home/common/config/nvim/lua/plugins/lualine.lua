-- Ansible managed: templates/lua/plugins/lualine.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net

-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
    local condition = package.loaded["ollama"] and require("ollama").status ~= nil
    local status = require("ollama").status()

    if condition then
        if status == "IDLE" then
            return "IDLE"
        elseif status == "WORKING" then
            return "BUSY"
        end
    else
        return "OFF"
    end
end

local function get_git_base()
    local git_base = vim.g.git_base
    if git_base then
        if git_base:len() > 7 then
            return git_base:sub(1, 7) .. "..."
        else
            return git_base
        end
    else
        return "HEAD"
    end
end

-- Load and configure 'lualine'
require("lualine").setup({
    sections = {
        lualine_a = {},
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

require 'lualine'.setup {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { get_git_base },
    },
}
