local p = require("utils/pattern")

-- toggle relative line number based on mode + focus
local augroup_number_toggle = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup_number_toggle,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup_number_toggle,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			vim.cmd("redraw")
		end
	end,
})

-- highlight text on yank
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

-- auto set cwd based on project root pattern
function _G.AutoSetCwd()
	-- don't set cwd with the following filetype
	if vim.tbl_contains({ "telescope", "aerial", "qf", "NvimTree", "packer", "oil" }, vim.filetype) then
		return
	end
	local root, _ = p.find_pattern_root()
	if root == nil then
		return false
	end
	if vim.fn.getcwd() ~= root then
		vim.api.nvim_set_current_dir(root)
	end
	return true
end

vim.cmd([[
augroup set_cwd
autocmd!
autocmd BufEnter * lua AutoSetCwd()
augroup END
]])

local wo = vim.wo
local au = vim.api.nvim_create_autocmd
au("WinEnter", {
	callback = function()
		if vim.bo.filetype ~= "" then -- disable it for terminal
			wo.cursorline = true
		else
			wo.cursorline = false
		end
	end,
})
au("WinLeave", {
	callback = function()
		wo.cursorline = false
	end,
})

-- Delayed highlight Cursorline autocmd
-- but terminal in a newtab would still display a cursorline
-- which is super annoying, disable it for now

-- wo.cursorlineopt = "both"
-- local timer = vim.loop.new_timer()
-- local timeout = 500
-- au({ "CursorMoved", "CursorMovedI" }, {
-- 	callback = function()
-- 		wo.cursorlineopt = "number"
-- 		timer:start(
-- 			timeout,
-- 			0,
-- 			vim.schedule_wrap(function()
-- 				wo.cursorlineopt = "both"
-- 			end)
-- 		)
-- 	end,
-- })
