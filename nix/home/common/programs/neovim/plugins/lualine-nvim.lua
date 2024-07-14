-- Load and configure 'lualine'
require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})
