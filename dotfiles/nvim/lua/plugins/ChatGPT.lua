return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
  -- I'm just going to store it in env var
  -- opts = {
  --   api_key_cmd = "op read op://Personal/OpenAI_API_Key/credentials --no-newline"
  -- }
