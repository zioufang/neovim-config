local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

vim.diagnostic.config({
	virtual_text = true,
})

local on_attach = function(_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:h vim.lsp.*`
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>jR", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", bufopts) -- TOOD: might be a better way
	vim.keymap.set("n", "<leader>ji", ":LspInfo<Cr>", bufopts)

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup()
mason_lspconfig.setup({
	ensure_installed = {
		"sumneko_lua",
		"rust_analyzer",
		"pyright",
		"gopls",
		"tsserver", -- js + ts
		"marksman", -- markdown
	},
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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
		})
	end,

	-- default lua lsp to neovim variant
	["sumneko_lua"] = function()
		require("neodev").setup({})
		lspconfig.sumneko_lua.setup({})
	end,
})

-- TODO: change diagnostics underline to wavy + pretty sign
