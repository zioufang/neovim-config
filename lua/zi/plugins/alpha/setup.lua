local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- to pick a specific header use the index key, i.e. `.dos_rebel`
-- `.random()` for random block
dashboard.section.header.val = require("zi.plugins.alpha.headers").random()
dashboard.section.header.opts = {
	position = "center",
	hl = "AlphaHeader",
}
-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("SPC f r", "  > Recent Files"),
	dashboard.button("SPC p", "  > Find Project"),
	dashboard.button("SPC t", "  > Nvim Tree"),
	dashboard.button("-", "  > File Browser"),
	dashboard.button("e", "  > New File", ":enew <BAR> startinsert <CR>"),
	dashboard.button("v", "  > Settings", ":e $MYVIMRC <CR>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup({
	layout = {
		{ type = "padding", val = 20 },
		dashboard.section.header,
		{ type = "padding", val = 5 },
		dashboard.section.buttons,
		dashboard.section.footer,
	},
	opts = {
		margin = 5,
	},
})
