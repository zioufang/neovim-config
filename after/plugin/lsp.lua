local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

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

local bufopts = { noremap = true, silent = true }

-- See `:h vim.lsp.*`
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "<leader>js", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "<leader>jR", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", bufopts) -- TOOD: might be a better way
vim.keymap.set("n", "<leader>ji", ":LspInfo<Cr>", bufopts)

-- Create a command `:Format` local to the LSP buffer
-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
-- 	vim.lsp.buf.format()
-- end, { desc = "Format current buffer with LSP" })

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
	["sumneko_lua"] = function()
		require("neodev").setup({})
		lspconfig.sumneko_lua.setup({ capabilities = capabilities })
	end,
})

-- TODO: change diagnostics underline to wavy + pretty sign
