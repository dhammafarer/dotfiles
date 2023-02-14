local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'
  --use 'rcarriga/nvim-notify'            -- Notifications manager
  use {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
}
  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use 'nvim-lualine/lualine.nvim'
  use 'romgrk/barbar.nvim'
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})



  --> LSP plugins
  use 'neovim/nvim-lspconfig'           -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp'                -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'            -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'        -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                -- Snippets plugin
  use 'onsails/lspkind.nvim'            -- Pictograms for lsp
  use('jose-elias-alvarez/null-ls.nvim')-- Prettier
  use('MunifTanjim/prettier.nvim')      -- Prettier
  use('mg979/vim-visual-multi')         -- Multiple cursors
  use('HiPhish/jinja.vim')              -- jinja syntax highlighting

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
