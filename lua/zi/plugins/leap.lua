return {
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").opts.safe_labels = {}
			require("leap").opts.labels =
				{ "f", "d", "s", "g", "j", "k", "l", "h", "r", "t", "v", "b", "y", "u", "n", "a" }
			require("leap").opts.case_sensitive = true
			require("leap").add_default_mappings()
		end,
	},
}
