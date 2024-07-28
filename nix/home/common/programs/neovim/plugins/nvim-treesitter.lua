-- vim.opt.runtimepath:append("$HOME/.local/share/nvim/lazy/nvim-treesitter")

require("nvim-treesitter.configs").setup({})
-- require("nvim-treesitter.configs").setup({
--   --parser_install_dir ="$HOME/.local/share/nvim/lazy/nvim-treesitter",
--     ensure_installed = {},
-- 	auto_install = false, -- Parsers are managed by Nix
-- 	indent = {
-- 		enable = true,
-- 	},
-- 	highlight = {
-- 		enable = true,
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- })
