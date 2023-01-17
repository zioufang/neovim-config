return {
	{
		"kevinhwang91/nvim-bqf",
		opts = { auto_resize_height = true },
	},

	{ "gabrielpoca/replacer.nvim" }, -- edit directly in quickfix buffer

	-- prettier qf
	{
		"https://gitlab.com/yorickpeterse/nvim-pqf.git",
		config = true,
		event = "BufNew qf",
	},
}
