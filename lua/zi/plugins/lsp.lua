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
					"gopls",
					"tsserver", -- js + ts
					"marksman", -- markdown
					"bashls",
					"jsonls",
					"taplo", -- toml
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
						-- assume there is always an `.venv` virtualenv in every python project root
						before_init = function(_, config)
							local Path = require("plenary.path")
							local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
							if venv:joinpath("bin"):is_dir() then
								config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
							else
								config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
							end
						end,
						capabilities = capabilities,
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

				-- ["rust_analyzer"] = function()
				-- 	lspconfig.rust_analyzer.setup({
				-- 		settings = {
				-- 			inlayHints = { locationLinks = false },
				-- 			procMacro = { enable = true },
				-- 			diagnostics = { disabled = { "unresolved-proc-macro" } },
				-- 		},
				-- 		capabilities = capabilities,
				-- 	})
				-- end,
			})
		end,
	},
}
