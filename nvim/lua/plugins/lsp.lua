return {
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        poll_rate = 0,
        suppress_on_insert = false,
        ignore_done_already = false,
        ignore_empty_message = false,
        display = {
          render_limit = 16,
          done_ttl = 3,
          progress_icon = {
            pattern = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            period = 1,
          },
        },
      },
    },
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ui = { border = "rounded" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim" },
      "mason-org/mason-lspconfig.nvim",
      "folke/lazydev.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require("lazydev").setup()
      require("mason").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          tsserver = function()
            local ok, ts_tools = pcall(require, "typescript-tools")
            if ok then
              ts_tools.setup({
                settings = {
                  expose_as_code_action = {
                    "fix_all",
                    "add_missing_imports",
                    "remove_unused",
                  },
                },
              })
            else
              vim.notify("typescript-tools not installed, falling back to tsserver", vim.log.levels.WARN)
              require("lspconfig")["tsserver"].setup({ capabilities = capabilities })
            end
          end,

          ["jdtls"] = function()
            local ok, _ = pcall(require, "jdtls")
            if ok then
              vim.api.nvim_create_autocmd("FileType", {
                pattern = { "java" },
                callback = function()
                  require("jdtls").start_or_attach({
                    cmd = {
                      "jdtls",
                      "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$MASON/share/jdtls/lombok.jar")),
                    },
                    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
                  })
                end,
              })
            else
              require("lspconfig")["jdtls"].setup({ capabilities = capabilities })
            end
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text = {
          signs = true,
          severity_sort = true,
        },
        float = {
          signs = true,
          severity_sort = true,
          format = function(diagnostic)
            return string.format("%s [%s] (%s)", diagnostic.message, diagnostic.code, diagnostic.source)
          end,
          suffix = "",
        },
      })

      require("lsp_signature").setup({
        bind = true,
        hint_enable = false,
        handler_opts = { border = "rounded" },
      })

      local format_is_enabled = true
      vim.api.nvim_create_user_command("LspFormatToggle", function()
        format_is_enabled = not format_is_enabled
        vim.notify("Autoformat " .. (format_is_enabled and "enabled" or "disabled"))
      end, {})

      vim.api.nvim_create_user_command("LspFormat", function()
        vim.lsp.buf.format()
        vim.diagnostic.enable()
      end, {})

      local _augroups = {}
      local get_formatting_augroup = function(client)
        if not _augroups[client.id] then
          local id = vim.api.nvim_create_augroup("lsp-attach-" .. client.name, { clear = true })
          _augroups[client.id] = id
        end
        return _augroups[client.id]
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-main", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf
          if client == nil or bufnr == nil then
            return
          end

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = get_formatting_augroup(client),
            buffer = bufnr,
            callback = function()
              if not client.server_capabilities.documentFormattingProvider then
                return
              end
              if client.name == "tsserver" then
                return
              end
              if not format_is_enabled then
                return
              end
              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              })
            end,
          })
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "go.mod", "go.sum" },
        callback = function()
          vim.cmd("LspRestart")
        end,
      })
    end,
  },
}
