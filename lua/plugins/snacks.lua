return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      autosave = {
        enabled = true,
        debounce = 3000,
        notify = true,
      },
      history = false,
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<CR>"] = "explorer_open_tab",
                ["o"] = "explorer_open_tab",
              },
            },
          },
          actions = {
            explorer_open_tab = function(picker, item)
              if not item then
                return
              end
              if item.dir then
                picker:action("confirm")
                return
              end
              picker:close()
              vim.cmd("tabedit " .. vim.fn.fnameescape(item.file or item.path or ""))
            end,
          },
        },
      },
    },
  },
}
