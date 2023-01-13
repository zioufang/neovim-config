vim.o.background = "dark"

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_line_highlight = 1

-- sonokai has higher contrast
vim.g.sonokai_better_performance = 1
vim.g.sonokai_style = "shusia" -- espresso
vim.g.sonokai_diagnostic_virtual_text = "colored"
vim.g.sonokai_diagnostic_text_highlight = 1
vim.g.sonokai_diagnostic_line_highlight = 1

vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("colorscheme sonokai")

-- Custom color needs to be placed after the colorscheme
-- https://jonasjacek.github.io/colors/

-- CursorLine setup
-- line number at cursor
vim.cmd("hi CursorLineNr guifg=#b48ead")
-- highlight line number + deplayed text line
local au = vim.api.nvim_create_autocmd
local wo = vim.wo
local timer = vim.loop.new_timer()
local timeout = 500
wo.cursorline = true
au("WinEnter", {
	callback = function()
		wo.cursorline = true
	end,
})
au("WinLeave", {
	callback = function()
		wo.cursorline = false
	end,
})
au({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		wo.cursorlineopt = "number"
		timer:start(
			timeout,
			0,
			vim.schedule_wrap(function()
				wo.cursorlineopt = "both"
			end)
		)
	end,
})
