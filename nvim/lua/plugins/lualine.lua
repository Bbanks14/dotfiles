return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    opts = {
      options = {
        theme = "auto",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        always_show_tabline = true,
        refresh = {
          statusline = 2000,
          tabline = 1000,
          winbar = 1000,
        },
        events = {
          "WinEnter",
          "BufEnter",
          "BufWritePost",
          "SessionLoadPost",
          "FileChangedShellPost",
          "VimResized",
          "Filetype",
          "CursorMoved",
          "CursorMovedI",
          "ModeChanged",
        },
      },
      sections = {
        lualine_a = { "mode", "search_count", "selection_count" },
        lualine_b = { "branch", "diff", "diagnostics", "git_blame" },
        lualine_c = { "filename", "lsp_status" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress", "location" },
        lualine_z = { "time" },
      },
      tabline = {
        lualine_a = { "tabs" },
        lualine_z = { "buffers" },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },
}
