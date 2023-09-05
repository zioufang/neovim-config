return {
	"jose-elias-alvarez/null-ls.nvim",
	enabled = false,
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local nls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("zi_null_ls_format", {})

		nls.setup({
			sources = {
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.isort,
				nls.builtins.formatting.black,
				nls.builtins.formatting.deno_fmt,
				nls.builtins.formatting.goimports,
				nls.builtins.formatting.gofumpt,
				nls.builtins.formatting.terraform_fmt,
				nls.builtins.formatting.fish_indent,
				nls.builtins.formatting.taplo,
				nls.builtins.formatting.shfmt,
				nls.builtins.formatting.clang_format,
				-- rustfmt edition args read from Cargo.toml
				nls.builtins.formatting.rustfmt.with({
					extra_args = function(params)
						local Path = require("plenary.path")
						local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

						if cargo_toml:exists() and cargo_toml:is_file() then
							for _, line in ipairs(cargo_toml:readlines()) do
								local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
								if edition then
									return { "--edition=" .. edition }
								end
							end
						end
						-- default edition when we don't find `Cargo.toml` or the `edition` in it.
						return { "--edition=2021" }
					end,
				}),

				-- code actions
				nls.builtins.code_actions.shellcheck,

				-- diagnostics
				nls.builtins.diagnostics.actionlint, -- github action linter
				nls.builtins.diagnostics.checkmake, -- Makefile linter
				nls.builtins.diagnostics.fish, -- for fish shell
				nls.builtins.diagnostics.vale, -- for spelling + style for Markup (e.g. Markdown, rst, etc.)

				-- qml
				-- nls.builtins.diagnostics.qmllint,
				nls.builtins.formatting.qmlformat,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								-- only use null-ls for formatting
								-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
								filter = function(client2)
									-- apply whatever logic you want (in this example, we'll only use null-ls)
									return client2.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		})
	end,
}
