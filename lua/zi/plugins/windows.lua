return {
	-- tmux
	{
		"numToStr/Navigator.nvim",
		config = true,
	},

	-- maximize with gaps
	{
		"anuvyklack/windows.nvim",
		keys = {
			{ "<F10>", "<Cmd>WindowsMaximize<Cr>" },
			{ "<F11>", "<Cmd>WindowsMaximizeVertically<Cr>" },
		},
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 5
			vim.o.winminwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				autowidth = {
					enable = false,
				},
			})
		end,
	},

	-- fully maximize but don't work well with special buffer types
	{
		"declancm/maximize.nvim",
		keys = {
			{ "<F12>", "<Cmd>lua require('maximize').maximize" },
		},
		opts = {
			default_keymaps = false,
		},
	},

	-- swapping windows
	{
		"sindrets/winshift.nvim",
		enabled = false,
		config = function()
			require("winshift").setup({
				window_picker = function()
					return require("winshift.lib").pick_window({
						picker_chars = "SDFGHJKL1234567890",
					})
				end,
			})
			-- vim.keymap.set("n", "<C-W>M", "<Cmd>WinShift<Cr>")
			-- need to set cmdheight to non-zero, so the selection shows up. set it back to one afterwards (:set ch=0)
			vim.keymap.set("n", "<C-W>m", "<Cmd>set cmdheight=1<Cr><Cmd>WinShift swap<Cr>")
		end,
	},
}
