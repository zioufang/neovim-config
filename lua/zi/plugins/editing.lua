return {
	-- gc for comment
	{
		"numToStr/Comment.nvim",
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		config = true,
	},

	{
		"kylechui/nvim-surround",
		config = true,
	},

	-- better substitution + case coercion
	{ "tpope/vim-abolish" },
	-- preview support for abolish
	{
		"markonm/traces.vim",
		config = function()
			vim.g.traces_abolish_integration = 1
		end,
	},

	-- iv + av for subwords in snake/camel cases
	{ "kana/vim-textobj-user", dependencies = "Julian/vim-textobj-variable-segment" },
}
