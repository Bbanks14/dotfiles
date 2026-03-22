return {
  {
    {
      "rmagatti/goto-preview",
      config = function()
        require("goto-preview").setup({})
      end,
      event = "VeryLazy",
    },

    -- Telescope for general navigation
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("telescope").setup({})
      end,
      cmd = "Telescope",
      event = "VeryLazy",
    },
  },
}
