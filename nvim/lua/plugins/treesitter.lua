return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "typescript",
        "vim",
      },
      actions = {
        open_file = {
          window_picker = { enable = false },
        },
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
