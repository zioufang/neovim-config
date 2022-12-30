vim.o.winwidth = 5
vim.o.winminwidth = 5
vim.o.equalalways = false
require("windows").setup({
	autowidth = {
		enable = false,
	},
})

local function cmd(command)
	return table.concat({ "<Cmd>", command, "<CR>" })
end

vim.keymap.set("n", "<F12>", cmd("WindowsMaximize"))
vim.keymap.set("n", "<C-w>-", cmd("WindowsMaximizeVertically"))
vim.keymap.set("n", "<C-w>\\", cmd("WindowsMaximizeHorizontally"))
vim.keymap.set("n", "<C-w>=", cmd("WindowsEqualize"))
