local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = ">", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local normal_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local normal_mappings = {
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["f"] = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["H"] = { "<cmd>Alpha<cr>", "Home Dashboard" },
  ["j"] = { "<cmd>e ~/vault/jrn/" .. os.date "%Y.%m.%d" .. ".md<cr>", "jrn today"},
  [" "] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, find_command = {'rg', '--files', '--hidden', '-g', '!.git'}})<cr>",
    "Find Files in Project",
  },
  ["/"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["?"] = { "<cmd>Telescope live_grep_args theme=ivy<cr>", "Find Text with Args" },
  ["."] = { "<cmd>Telescope file_browser<cr>", "Find File" },
  ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["n"] = { "<cmd>lua require('telescope.builtin').find_files({cwd = '~/org'})<cr>", "Org Notes" },
  ["v"] = { "<cmd>lua require('telescope.builtin').find_files({cwd = '~/vault'})<cr>", "Vault" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },

  a = {
    name = "AI",
    a = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
    T = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
    t = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
  },

  g = {
    name = "Git",
    --g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    g = { "<cmd>lua require 'neogit'.open()<CR>", "neogit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    z = { "<cmd>Telescope git_stash<cr>", "Apply stash" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    s = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    o = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    I = { "<cmd>LspInfo<cr>", "Info" },
    h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      "Prev Diagnostic",
    },
    v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    t = {"<cmd>:Telescope lsp_type_definitions<cr>", "Type Definitions"},
  },

  s = {
    name = "Search",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Buffer" },
  },

   m = {
    name = "modify",
    w = {"<cmd>:set wrap!<cr>", "Toggle Wrap"},
    p = {"<cmd>:echo expand('%p')<cr>", "Full Path"},
    s = {"<cmd>:put =strftime('# %Y.%m.%d')<cr>", "Timestamp"},
    c = {"<cmd>:lua require('cmp').setup.buffer { enabled = false }<cr>", "Disable Autocomplete"},
    C = {"<cmd>:lua require('cmp').setup.buffer { enabled = true }<cr>", "Enable Autocomplete"}
  },
  -- r = {
  --   name = "repl",
  --   --r = {"<cmd>:SendPyObject<cr>", "Send Python object"},
  --   b = {"<cmd>lua require('iron.core').send_file()<cr>", "Send Python Buffer"},
  --   c = {"<cmd>lua require('iron.core').send_motion({'j'})<cr>", "Send Jupyter Cell"},
  -- }
}

local visual_opts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visual_mappings = {
  ["r"] ={"<cmd>lua require('iron.core').visual_send()<cr>", "Send Python Selection"},
  a = {
    name = "AI",
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
    T = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
    t = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
  },
}

which_key.setup(setup)
which_key.register(normal_mappings, normal_opts)
which_key.register(visual_mappings, visual_opts)
