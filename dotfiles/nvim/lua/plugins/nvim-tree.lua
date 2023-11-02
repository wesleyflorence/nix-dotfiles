return {
  "nvim-tree/nvim-tree.lua",
  --version = "*",
  --lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- svelte logos broken in iterm for some reason
    require("nvim-web-devicons").set_icon {
      svelte = {
        icon = "",
        color = "#bf2e00",
        cterm_color = "160",
        name = "svelte"
      },
      ["svelte.config.js"] = {
        icon = "",
        color = "#bf2e00",
        cterm_color = "160",
        name = "svelte"
      }
    }
    require("nvim-tree").setup {
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      renderer = {
        root_folder_modifier = ":t",
        group_empty = true,
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      view = {
        adaptive_size = true,
        --width = 30,
        --height = 30,
        side = "left",
      },
    }
  end
}
