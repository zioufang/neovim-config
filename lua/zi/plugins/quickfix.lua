return {
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		opts = { auto_resize_height = true },
	},

	{ "gabrielpoca/replacer.nvim", ft = "qf" }, -- edit directly in quickfix buffer

	-- prettier qf
	{
		"https://gitlab.com/yorickpeterse/nvim-pqf.git",
		config = true,
		event = "BufNew qf",
	},
}
