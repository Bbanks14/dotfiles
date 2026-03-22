return {
  {
    "nvim-mini/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        ";f",
        function()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Find files (respects .gitignore)",
      },
      {
        ";r",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "\\\\",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "List buffers",
      },
      {
        ";;",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume previous picker",
      },
      {
        ";e",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "List diagnostics",
      },
      {
        ";s",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "List treesitter symbols",
      },
      {
        "sf",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = vim.fn.expand("%:p:h"),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open file browser",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })

      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }

      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            i = {
              ["<CR>"] = actions.select_tab,
            },
            n = {
              ["<CR>"] = actions.select_tab,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      -- fixed: fb_actions accessed only after load_extension is called
      local fb_actions = telescope.extensions.file_browser.actions

      -- patch the normal-mode file_browser mappings post-setup
      local fb_mappings = opts.extensions.file_browser.mappings.n
      fb_mappings["N"] = fb_actions.create
      fb_mappings["h"] = fb_actions.goto_parent_dir
      fb_mappings["<C-u>"] = function(prompt_bufnr)
        for _ = 1, 10 do
          actions.move_selection_previous(prompt_bufnr)
        end
      end
      fb_mappings["<C-d>"] = function(prompt_bufnr)
        for _ = 1, 10 do
          actions.move_selection_next(prompt_bufnr)
        end
      end
    end,
  },
}
