return {
	"simrat39/rust-tools.nvim",
	ft = "rust",
	config = function()
		require("rust-tools").setup({
			tools = {
				inlay_hints = {
					auto = false,
					only_current_line = false,
				},
			},
			server = {
				settings = {
					["rust-analyzer"] = {
						inlayHints = { locationLinks = false },
					},
				},
			},
		})

		local rt = require("rust-tools")
		-- open doc under cursor
		--  because netrw#BrowseX is disabled for lir/nvim-tree etc, but is needed to do open url in browser for rust_tools.open_external_docs
		-- https://github.com/simrat39/rust-tools.nvim/blob/99fd1238c6068d0637df30b6cee9a264334015e9/lua/rust-tools/external_docs.lua#L12
		local function open_external_docs()
			rt.utils.request(0, "experimental/externalDocs", vim.lsp.util.make_position_params(), function(_, url)
				if url then
					vim.fn.execute("!open " .. url)
				end
			end)
		end

		vim.keymap.set("n", "<leader>jd", open_external_docs, {})
	end,
}
