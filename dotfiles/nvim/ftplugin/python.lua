local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  r = {
    name = "Python Repl",
    b = {"<cmd>lua require('iron.core').send_file()<cr>", "Send Python Buffer"},
    c = {"<cmd>lua require('iron.core').send_motion({'j'})<cr>", "Send Jupyter Cell"},
  },
}

which_key.register(mappings, opts)

