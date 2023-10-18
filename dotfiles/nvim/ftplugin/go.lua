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
    name = "GoLang",
    a = { "<Cmd>GoAddTest<CR>", "GoAddTest" },
    e = { "<Cmd>GoIfErr<CR>", "GoIfErr" },
    f = { "<Cmd>GoFormat<CR>", "GoFormat" },
    g = { "<Cmd>GoGet<CR>", "GoGet" },
    t = { "<Cmd>GoTest<CR>", "GoTest" },
  },
}

which_key.register(mappings, opts)

-- Golang prefers tabs and 4 spaces
local vim_options = {
  expandtab = false,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 2 spaces for a tab
}

for k, v in pairs(vim_options) do
  vim.opt[k] = v
end
