return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local copilot = require("copilot")

    copilot.setup({
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_next = "<C-j>",
          jump_prev = "<C-k>",
          accept = "<tab>",
          refresh = "rc",
          open = "<M-CR>",
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = "<M-w>",
          accept_line = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Open Copilot panel" })
    keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", { desc = "Enable Copilot" })
    keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", { desc = "Disable Copilot" })
    keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "Copilot status" })
  end,
}
