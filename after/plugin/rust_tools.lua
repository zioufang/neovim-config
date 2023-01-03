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
