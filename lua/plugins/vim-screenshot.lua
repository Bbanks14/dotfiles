return {
  "SergioRibera/vim-screenshot",
  cmd = { "Screenshot" },
  keys = {
    {
      "<leader>hss",
      ":ScreenShot<CR>",
      mode = "v",
      desc = "vim-screenshot: Take with vim-screenshot",
    },
    {
      "<leader>hsc",
      function()
        vim.cmd("ScreenShot copy")
      end,
      mode = "v",
      desc = "Vim-Screenshot: Copy to clipboard",
    },
    {
      "<leader>sp",
      function()
        vim.cmd("ScreenShot save ~/Pictures/code-snaps/")
      end,
      mode = "v",
      desc = "Vim-Screenshot: Save to Pictures",
    },
  },
  config = function()
    vim.g.vim_screenshot = {
      output_path = "~/Pictures/code-snaps/",
      use_current_theme = true,
      window_controls = true,
      show_line_numbers = true,
      font_family = "JetBrainsMono Nerd Font",
      font_size = 14,
      padding = 40,
      background = "#1e1e2e",
      shadow = true,
      rounded_corners = true,
      border_radius = 10,
    }
  end,
}
