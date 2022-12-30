local colors = require("tokyonight.colors").setup()

require("scrollbar").setup({
	show_in_active_only = false,
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = false, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
	},
	handle = {
		color = colors.bg_highlight,
	},
	marks = {
		Search = { text = { "-" }, priority = 1, color = colors.orange },
		Error = { text = { "=" }, priority = 2, color = colors.error },
		Warn = { text = { "=" }, priority = 3, color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
})
