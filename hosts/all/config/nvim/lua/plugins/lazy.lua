-- Ansible managed: templates/lua/plugins/lazy.lua.j2 modified on 2024-05-30 02:32:17 by pl on dev.pale.paradise-liberty.ts.net
require("lazy").setup({
    {
      "EdenEast/nightfox.nvim",
    },
    {
      "ellisonleao/gruvbox.nvim",
    },
    {
      "nvim-tree/nvim-web-devicons",
    },
    {
      "nvim-tree/nvim-tree.lua",
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "rcarriga/nvim-notify",
    },
    {
      "romgrk/barbar.nvim",
    },
    {
      "phaazon/hop.nvim",
      branch = "v2",
    },
    {
      "nvim-lualine/lualine.nvim",
    },
    {
      "mg979/vim-visual-multi",
    },
    {
      "windwp/nvim-autopairs",
    },
    {
      "kylechui/nvim-surround",
      version = "*",
    },
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },
    {
      "voldikss/vim-floaterm",
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
    },
    {
      "ludovicchabant/vim-gutentags",
    },
    {
      "barklan/capslock.nvim",
    },
    {
      "serenevoid/kiwi.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "nomnivore/ollama.nvim",
      cmd = {
        "Ollama",
        "OllamaModel",
        "OllamaServe",
        "OllamaServeStop",
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "tpope/vim-fugitive",
    },
    {
      "lewis6991/gitsigns.nvim",
    },
    {
      "nvimtools/none-ls.nvim",
    },
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
    },
    {
      "williamboman/mason-lspconfig.nvim",
    },
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
      },
    },
    {
      "folke/neodev.nvim",
    },
    {
      "neovim/nvim-lspconfig",
    },
    {
      "MunifTanjim/prettier.nvim",
    },
    {
      "hrsh7th/cmp-path",
    },
    {
      "hrsh7th/nvim-cmp",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    {
      "saadparwaiz1/cmp_luasnip",
    },
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },
    {
      "onsails/lspkind.nvim",
    },
    {
      "simrat39/rust-tools.nvim",
    },
    {
      "mfussenegger/nvim-dap",
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
    },
    {
      "someone-stole-my-name/yaml-companion.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
    {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
      "tpope/vim-rails"
    },
})
