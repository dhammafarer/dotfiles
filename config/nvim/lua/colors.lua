require('nightfox').setup({
  options = {
      transparent = true,
      dim_inactive = false,
  },
})

vim.cmd("colorscheme nightfox")

-- vim.api.nvim_set_hl(0, "Pmenu", { ctermbg=0, ctermfg=15 })
-- vim.api.nvim_set_hl(0, "Comment", { ctermbg=0, ctermfg=8 })
-- vim.api.nvim_set_hl(0, "Normal", { ctermbg=none })
