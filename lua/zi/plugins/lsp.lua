return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Show line diagnostics automatically in hover window
      -- You will likely want to reduce updatetime which affects CursorHold
      -- note: this setting is global and should be set only once
      -- vim.o.updatetime = 250
      -- vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
      --
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "⚠" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        signs = {
          active = signs,
        },
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
        },
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      --- toggle inlay hints
      vim.g.inlay_hints_visible = false
      local function toggle_inlay_hints()
        if vim.g.inlay_hints_visible then
          vim.g.inlay_hints_visible = false
          vim.lsp.inlay_hint(bufnr, false)
        else
          if client.server_capabilities.inlayHintProvider then
            vim.g.inlay_hints_visible = true
            vim.lsp.inlay_hint(bufnr, true)
          else
            print("no inlay hints available")
          end
        end
      end

      -- TODO: try on_attach (defined in keymaps for now)
      -- local bufopts = { noremap = true, silent = true }
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      -- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
      -- vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)
      -- vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, bufopts)
      -- vim.keymap.set("n", "<leader>le", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", bufopts) -- TOOD: might be a better way

      -- Create a command `:Format` local to the LSP buffer
      -- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      -- 	vim.lsp.buf.format()
      -- end, { desc = "Format current buffer with LSP" })

      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      require("mason").setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "pyright",
          -- "gopls",
          "ts_ls",    -- js + ts
          "marksman", -- markdown
          "bashls",
          "jsonls",
          "helm_ls",
          "yamlls", -- would mess up helm without helm_ls setup
          "terraformls",
          "taplo",  -- toml
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- python
        ["pyright"] = function()
          lspconfig.pyright.setup({
            -- will look for a '.venv/' in any dir with 'pyproject.toml'
            before_init = function(_, config)
              local Path = require("plenary.path")
              local venv = Path:new(config.root_dir, ".venv", "bin", "python")
              if venv:is_file() then
                config.settings.python.pythonPath = tostring(venv)
              else
                config.settings.python.pythonPath = tostring(venv) .. " missing"
              end
            end,
            capabilities = capabilities,
          })
        end,

        ["helm_ls"] = function()
          lspconfig.helm_ls.setup({
            settings = {
              ['helm-ls'] = {
                valuesFiles = {
                  mainValuesFile = "values.yaml",
                  lintOverlayValuesFile = "values.lint.yaml",
                  additionalValuesFilesGlobPattern = "values*.yaml",
                },
                yamlls = {
                  enabled = false,
                  path = "yaml-language-server",
                }
              }
            }
          })
        end,
        -- default lua lsp to neovim variant
        ["lua_ls"] = function()
          -- require("neodev").setup({})
          lspconfig.lua_ls.setup({
            before_init = require("neodev.lsp").before_init,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
            capabilities = capabilities,
          })
        end,

        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup({
            settings = {
              inlayHints = { locationLinks = false },
              procMacro = { enable = true },
              diagnostics = { disabled = { "unresolved-proc-macro" } },
            },
            capabilities = capabilities,
            commands = {
              RustOpenDocs = {
                function()
                  vim.lsp.buf_request(vim.api.nvim_get_current_buf(), 'experimental/externalDocs',
                    vim.lsp.util.make_position_params(), function(err, url)
                      if err then
                        error(tostring(err))
                      else
                        --  because netrw#BrowseX is disabled for lir/nvim-tree etc, but is needed to do open url in browser for rust_tools.open_external_docs
                        -- https://github.com/simrat39/rust-tools.nvim/blob/99fd1238c6068d0637df30b6cee9a264334015e9/lua/rust-tools/external_docs.lua#L12
                        -- vim.fn['netrw#BrowseX'](url, 0)
                        vim.fn.execute("!open " .. url)
                      end
                    end)
                end,
                description = 'Open documentation for the symbol under the cursor in default browser',
              },
            },
          })
        end,
      })
    end,
  },
}
