local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"rust_analyzer",
	"pyright",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({ select = true }),
	-- ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- disable certain lsp
	-- if client.name == "eslint" then
	-- 	vim.cmd.LspStop("eslint")
	-- 	return
	-- end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- use default gd if lsp is not detected, since this is in a on_attach block
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
