return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {},
    config = function(_, opts)
      require("go").setup(opts)
      vim.api.nvim_create_augroup("GoFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        group = "GoFormat",
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
  },
}
