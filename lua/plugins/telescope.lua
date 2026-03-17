return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "trouble.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
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
            ["<CR>"] = require("telescope.actions").select_tab,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
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
              ["N"] = require("telescope").extensions.file_browser.actions.create,
              ["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
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

    local keymap = vim.keymap
    keymap.set("n", ";f", function()
      require("telescope.builtin").find_files({ no_ignore = false, hidden = true })
    end, { desc = "Find files in cwd respecting .gitignore" })
    keymap.set("n", ";r", function()
      require("telescope.builtin").live_grep()
    end, { desc = "Live grep in cwd respecting .gitignore" })
    keymap.set("n", "\\", function()
      require("telescope.builtin").buffers()
    end, { desc = "List open buffers" })
    keymap.set("n", ";;", function()
      require("telescope.builtin").resume()
    end, { desc = "Resume previous Telescope picker" })
    keymap.set("n", ";e", function()
      require("telescope.builtin").diagnostics()
    end, { desc = "Show diagnostics for buffers" })
    keymap.set("n", ";s", function()
      require("telescope.builtin").treesitter()
    end, { desc = "List functions and variables via Treesitter" })
    keymap.set("n", "sf", function()
      local telescope = require("telescope")
      local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
      end
      telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40 },
      })
    end, { desc = "Open file browser under current buffer path" })

    -- Additional keymaps you provided
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope gh<cr>", { desc = "GitHub search" })
  end,
}
