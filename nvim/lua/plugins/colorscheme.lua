return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false, -- load at startup to avoid default colorscheme flash on startup.
    priority = 1000,
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50FA7B",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
          bright_red = "#FF6E6E",
          bright_green = "#69FF94",
          bright_yellow = "#FFFFA5",
          bright_blue = "#D6ACFF",
          bright_magenta = "#FF92DF",
          bright_cyan = "#A4FFFF",
          bright_white = "#FFFFFF",
          menu = "#21222C",
          visual = "#3E4452",
          gutter_fg = "#4B5263",
          nontext_fg = "#3B4048",
          white = "#ABB2BF",
          black = "#191A21",
        },
        show_end_of_buffer = false,
        transparent_bg = true,
        lualine_bg_color = "#44475A",
        italic_comment = true,
        overrides = function(colors)
          return {
            NormalFloat = { bg = "NONE" },
            FloatBorder = { fg = colors.purple, bg = "NONE" },
            SignColumn = { bg = "NONE" },
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { fg = colors.purple, bg = "NONE" },
          }
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
