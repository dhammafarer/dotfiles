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
        return git_base
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
