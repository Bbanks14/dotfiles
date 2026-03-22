return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },

  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      })

      table.insert(opts.routes, {
        filter = { event = "notify", find = "Invalid node type" },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = { event = "notify", find = "Query error" },
        opts = { skip = true },
      })

      table.insert(opts.routes, {
        filter = { event = "msg_show", kind = "lua_error", find = "cmp_nvim_lsp" },
        opts = { skip = true },
      })

      -- focus tracking
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })

      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- filename left, tab number right
        name_formatter = function(tab)
          local name = vim.fn.fnamemodify(tab.name, ":t")
          name = name ~= "" and name or "[No Name]"
          local ok, devicons = pcall(require, "nvim-web-devicons")
          local icon = ""
          if ok then
            local i = devicons.get_icon(name)
            if i then
              icon = i .. " "
            end
          end
          return icon .. name .. "  " .. tab.tabnr
        end,
      },
    },
  },

  -- filename in winbar
  {
    "b0o/incline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local buffer = {
            ft_icon and {
              " ",
              ft_icon,
              " ",
              guibg = ft_color,
              guifg = helpers.contrast_color(ft_color),
            } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#363944",
          }
          return buffer
        end,
      })
    end,
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      {
        ";c",
        "<cmd>LazyGit<CR>",
        desc = "LazyGit: Open",
        silent = true,
        noremap = true,
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Database management
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },

  -- Database UI
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<CR>",     desc = "Database: Toggle UI" },
      { "<leader>dq", "<cmd>DBUIFindBuffer<CR>", desc = "Database: Find buffer" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 40
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      vim.g.db_ui_execute_on_save = 0
    end,
  },

  -- Database completion
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "tpope/vim-dadbod",
    },
    ft = { "sql", "mysql", "plsql" },
    init = function()
      vim.g.db_completion_use_default_keybindings = 0
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local ok, cmp = pcall(require, "cmp")
          if not ok then
            vim.notify("nvim-cmp not loaded. Database completion disabled.", vim.log.levels.WARN)
            return
          end
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end,
      })
    end,
  },
}
