return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "filesystem",
            position = "left",
          })
        end,
        desc = "Neo-tree: Toggle filesystem",
      },
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "filesystem",
            position = "left",
          })
        end,
        desc = "Neo-tree: Toggle filesystem",
      },
      {
        "<leader>eg",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "git_status",
            position = "left",
          })
        end,
        desc = "Neo-tree: Toggle git status",
      },
      {
        "<leader>eb",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            source = "buffers",
            position = "left",
          })
        end,
        desc = "Neo-tree: Toggle buffers",
      },
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_diagnostics = true,
      enable_git_status = true,
      sort_case_insensitive = true,

      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
          -- Fallback for files without a devicon
          default = "󰈙",
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "●",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
        -- Diagnostic icons in the sidebar
        diagnostics = {
          symbols = {
            hint = "󰌵",
            info = "",
            warn = "",
            error = "",
          },
          highlights = {
            hint = "DiagnosticSignHint",
            info = "DiagnosticSignInfo",
            warn = "DiagnosticSignWarn",
            error = "DiagnosticSignError",
          },
        },
      },

      -- ── Window settings ────────────────────────────────────────────────────
      window = {
        position = "left",
        width = 35,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = { "toggle_node", nowait = false },
          ["<CR>"] = "open_tab_drop",
          ["<C-v>"] = "open_vsplit",
          ["<C-s>"] = "open_split",
          ["<C-t>"] = "open_tabnew",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["l"] = "focus_preview",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["a"] = {
            "add",
            config = {
              show_path = "relative",
            },
          },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
          ["H"] = "toggle_hidden",
        },
      },

      -- ── Filesystem panel ───────────────────────────────────────────────────
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        -- Auto-update when files change on disk
        use_libuv_file_watcher = true,
        -- Start in the cwd, not the buffer directory
        bind_to_cwd = true,
        cwd_target = {
          sidebar = "tab",
          current = "window",
        },
        -- Always hide these
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
            ".git",
          },
          hide_by_pattern = {
            "*.pyc",
            "*_pycache_*",
          },
          always_show = {
            ".env", -- keep .env visible even when dotfiles hidden
            ".gitignore",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        window = {
          mappings = {
            -- Browse up to parent directory
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",     -- set this dir as the new root
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder", -- inline fuzzy filter
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["<C-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = "open_tab_drop",
          },
          fuzzy_finder_mappings = {
            ["<down>"] = "move_cursor_down",
            ["<C-j>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-k>"] = "move_cursor_up",
          },
        },
        components = {},
        renderers = {},
      },

      -- ── Buffers panel ──────────────────────────────────────────────────────
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        show_unloaded = true,
        group_empty_dirs = true,
        window = {
          mappings = {
            ["d"] = "buffer_delete",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["o"] = "open_tab_drop",
          },
        },
      },

      -- ── Git status panel ───────────────────────────────────────────────────
      git_status = {
        window = {
          position = "left",
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
            ["o"] = "open_tab_drop",
          },
        },
      },
    },
  },
}
