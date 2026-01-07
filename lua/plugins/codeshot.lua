-- Lua
return {
  "SergioRibera/codeshot.nvim",
  cmd = { "CodeShot" },
  keys = {
    {
      "<leader>hcs",
      ":SSSelected<CR>",
      mode = "v",
      desc = "(CodeShot): Save selected lines",
    },
    {
      "<leader>hcf",
      ":SSFocused<CR>",
      mode = "v",
      desc = "(CodeShot): Focus selected, (full file with highlights)",
    },
    {
      "<leader>hcw",
      ":SSFocused<CR>",
      mode = "v",
      desc = "(CodeShot): Whole file",
    },
  },
  config = function()
    require("codeshot").setup({
      bin_path = "sss_code",
      silent = true,
      window_controls = true,
      shadow = true,
      shadow_image = true,
      show_line_numbers = true,
      use_current_theme = true,
      tab_width = vim.opt.shiftwidth,
      radius = 15,
      author = "Bbanks14",
    })
  end,
}
