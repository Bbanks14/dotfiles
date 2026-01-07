return {
  "nmac427/guess-indent.nvim",
  event = "BufReadPre", -- optional lazy-loading trigger
  config = function()
    require("guess-indent").setup({})
  end,
}
