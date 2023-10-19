vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
local null_ls = require('null-ls')
local symbols_outline = require("symbols-outline")

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {
    "gopls",
    "cssls",
	  "tailwindcss",
    "cssmodules_ls",
    "emmet_ls", -- web
    "html",
    "jsonls",
    "jdtls",
    "groovyls",
    "lua_ls",
    "tflint",
    "terraformls",
    "tsserver",
    "pyright",
    "yamlls",
    "bashls",
    "clangd",
    "lemminx", --xml
    "bashls",
    "eslint",
    "kotlin_language_server",
    "templ",
    "nil_ls"
  },
  handlers = {
    lsp.default_setup,
  },
})

lsp.preset('recommended')
--lsp.nvim_lua_ls()
lsp.setup()

-- null-ls
local formatting = null_ls.builtins.formatting
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.shfmt,
    formatting.google_java_format,
    formatting.nixfmt,
  },
}

local mason_nullls = require("mason-null-ls")
mason_nullls.setup({
  automatic_installation = true,
  automatic_setup = true,
  ensure_installed = { "java-debug-adapter", "java-test"},
  handlers = {}
})

-- symbols-outline
symbols_outline.setup()

-- cmp
local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'}
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item()

  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})
