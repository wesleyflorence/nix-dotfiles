return {
  install = {
    missing = true,
    colorscheme = { "github-dark-default" }
  },

  defaults = { lazy = true },
  performance = {
    cache = {
      enabled = true,
    }
  },

  { "nvim-tree/nvim-web-devicons" },
  { "moll/vim-bbye" }, -- close buffer without messing up layout

  -- Whichkey
  { "folke/which-key.nvim" },

  -- Telescope
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "rcarriga/cmp-dap" }, -- source from nvim-dap REPL
  { "theHamsta/nvim-dap-virtual-text" },

  -- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"antoinemadec/FixCursorHold.nvim"}, -- This is needed to fix lsp doc highlight

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"saadparwaiz1/cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},

      -- Snippets
      {"L3MON4D3/LuaSnip"},
      {"rafamadriz/friendly-snippets"},
    }
  },
  { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
  { "jay-babu/mason-null-ls.nvim" }, -- for formatters and lintersplug
  { "ray-x/lsp_signature.nvim" },
  { "simrat39/symbols-outline.nvim" },
  { "b0o/SchemaStore.nvim" },
  { "RRethy/vim-illuminate" },
  { "lvimuser/lsp-inlayhints.nvim" },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

  -- cmp plugins
  { "hrsh7th/cmp-cmdline" }, -- cmdline completions

  -- Golang
  { 'crispgm/nvim-go' },
  { 'vrischmann/tree-sitter-templ'},

  -- Java
  { "mfussenegger/nvim-jdtls" },

  -- Python
  --{ "geg2102/nvim-python-repl" }, -- replaced with iron.nvim

  -- Undotree
  { "mbbill/undotree" },
}
