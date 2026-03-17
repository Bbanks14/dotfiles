return {
  "watzon/goshot.nvim",
  cmd = "Goshot",
  opts = {
    binary = "goshot", -- Path to goshot binary (default: "goshot")
    auto_install = false, -- Automatically install goshot if not found (default: false)
  },
  keys = {
    { "<leader>hys", "<cmd>Goshot<cr>", desc = "Take Code Screenshot", mode = { "n", "v" } },
  },
}
