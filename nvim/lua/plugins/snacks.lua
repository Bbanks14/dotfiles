return {
  {
    "folke/snacks.nvim",
    lazy = false, -- load at startup; dependency to other plugins.
    priority = 1000,
    opts = {
      autosave = {
        enabled = true,
        debounce = 3000,
        notify = true,
      },

      picker = {
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
  },
}
