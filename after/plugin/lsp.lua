local lsp = require("lsp-zero")

require("neodev").setup({})
require("fidget").setup({})

lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"rust_analyzer",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "eslint" then
		vim.cmd.LspStop("eslint")
		return
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>jj", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>jl", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>jR", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", opts) -- TOOD: might be a better way
	vim.keymap.set("n", "<leader>ji", ":LspInfo<Cr>", opts)
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
