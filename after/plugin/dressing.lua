require("dressing").setup({
	input = {
		insert_only = false,
	},
	mappings = {
		n = {
			["<Esc>"] = "Close",
			["<CR>"] = "Confirm",
		},
		i = {
			["<C-c>"] = "Close",
			["<CR>"] = "Confirm",
			["<C-Up>"] = "HistoryPrev",
			["<C-Down>"] = "HistoryNext",
		},
	},
})
