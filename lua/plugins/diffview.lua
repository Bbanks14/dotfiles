return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
  },
  opts = {},
}
