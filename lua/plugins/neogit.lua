return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-mini/mini.pick",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
  },

  -- Alternative Git clients
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    event = "VeryLazy",
  },

  -- Github URL handling for fugitive
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
    cmd = "GBrowse",
    event = "VeryLazy",
  },
}
