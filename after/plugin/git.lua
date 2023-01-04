require("gitsigns").setup({
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		local gs = package.loaded.gitsigns
		map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>gj", gs.next_hunk)
		map("n", "<leader>gk", gs.prev_hunk)
		map("n", "<leader>gu", gs.undo_stage_hunk)
		map("n", "<leader>gp", gs.preview_hunk)
		map("n", "<leader>gb", function()
			gs.blame_line({ full = false })
		end)
		map("n", "<leader>gd", gs.diffthis) -- diff against the index
		map("n", "<leader>gD", function()
			gs.diffthis("~") -- diff against last commit
		end)

		-- Text object
		map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
