return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  opts = {
    dir = "~/vault/",
    completion = {
      nvim_cmp = true,
      note_frontmatter_func = nil, -- no front matter for now, might customize
      daily_notes = {
        folder = "jrn",
      }
    },
    mappings = {}
  }
}
