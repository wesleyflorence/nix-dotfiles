return {
  "hkupty/iron.nvim",
  config = function ()
    require("iron.core").setup({
      config = {
        repl_open_cmd = require('iron.view').right("50%"),
        should_map_plug = false,
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "ipython" },
            format = require("iron.fts.common").bracketed_paste,
          },
        },
      },
    })
  end
}
