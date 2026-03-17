return {
  "mistricky/codesnap.nvim",
  build = "make build_generator", -- This must run successfully
  keys = {
    {
      "<leader>tc",
      '<cmd>lua require("codesnap").generate({ output_path = "clipboard" })<CR>',
      mode = "v",
      desc = "CodeSnap: Save selected code snapshot to clipboard",
    },
    {
      "<leader>ts",
      '<cmd>lua require("codesnap").generate()<CR>',
      mode = "v",
      desc = "CodeSnap: Save selected code snapshot to Pictures",
    },
  },
  opts = {
    save_path = "~/Pictures/code-snaps/",
    has_breadcrumbs = true,
    bg_theme = "catpuccin",
  },
}
