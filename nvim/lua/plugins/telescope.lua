return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-github.nvim",
    },
    keys = {
      { ";f", desc = "Find files" },
      { ";r", desc = "Live grep" },
      { "\\", desc = "List buffers" },
      { ";;", desc = "Resume picker" },
      { ";e", desc = "Diagnostics" },
      { ";s", desc = "Treesitter symbols" },
      { "sf", desc = "File browser" },
      { "<leader>ff", desc = "Fuzzy find files" },
      { "<leader>fr", desc = "Recent files" },
      { "<leader>fs", desc = "Find string" },
      { "<leader>fc", desc = "Find string under cursor" },
      { "<leader>ft", desc = "Find todos" },
      { "<leader>fg", desc = "GitHub search" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local transform = require("telescope.actions.mt").transform_mod
      local trouble = require("trouble")
      local trouble_tel = require("trouble.sources.telescope")

      local custom_actions = transform({
        open_trouble_qflist = function(_)
          trouble.toggle("quickfix")
        end,
      })

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          wrap_results = true,
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top", height = 0.75, width = 0.9 },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<CR>"] = actions.select_tab,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ["<C-t>"] = trouble_tel.open,
            },
            n = {},
          },
        },
        pickers = {
          diagnostics = {
            theme = "ivy",
            initial_mode = "normal",
            layout_config = { preview_cutoff = 9999 },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              n = {
                ["N"] = function(...)
                  require("telescope").extensions.file_browser.actions.create(...)
                end,
                ["h"] = function(...)
                  require("telescope").extensions.file_browser.actions.goto_parent_dir(...)
                end,
                ["<C-u>"] = function(prompt_bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_previous(prompt_bufnr)
                  end
                end,
                ["<C-d>"] = function(prompt_bufnr)
                  for _ = 1, 10 do
                    actions.move_selection_next(prompt_bufnr)
                  end
                end,
              },
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("gh")

      local builtin = require("telescope.builtin")
      local km = vim.keymap.set

      km("n", ";f", function()
        builtin.find_files({ no_ignore = false, hidden = true })
      end, { desc = "Find files in cwd" })
      km("n", ";r", function()
        builtin.live_grep()
      end, { desc = "Live grep in cwd" })
      km("n", "\\", function()
        builtin.buffers()
      end, { desc = "List open buffers" })
      km("n", ";;", function()
        builtin.resume()
      end, { desc = "Resume previous picker" })
      km("n", ";e", function()
        builtin.diagnostics()
      end, { desc = "Show diagnostics" })
      km("n", ";s", function()
        builtin.treesitter()
      end, { desc = "Treesitter symbols" })
      km("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
      km("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
      km("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      km("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
      km("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
      km("n", "<leader>fg", "<cmd>Telescope gh<cr>", { desc = "GitHub search" })
      km("n", "sf", function()
        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand("%:p:h"),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end, { desc = "Open file browser at buffer path" })
    end,
  },
}
