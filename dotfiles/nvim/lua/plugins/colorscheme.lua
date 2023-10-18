return {
  "projekt0n/github-nvim-theme",
  config = function()
    require('github-theme').setup({
      options = {
        theme_style = "dark_default",
        transparent = true,
        sidebars = {"qf", "vista_kind", "terminal", "packer"},
      }
    })
    vim.cmd('colorscheme github_dark')
  end,
  priority = 1000
}
