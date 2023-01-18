return {
	-- nicer default ui
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				insert_only = false,
			},
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<C-Up>"] = "HistoryPrev",
					["<C-Down>"] = "HistoryNext",
				},
			},
		},
	},
	-- scrollbar
	{
		"petertriho/nvim-scrollbar",
		config = function()
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
		end,
	},

	-- get lsp status out of status line
	{
		"j-hui/fidget.nvim",
		config = true,
	},

	-- show indent line
	{
		"lukas-reineke/indent-blankline.nvim",
		keys = { { "<leader>vi", "<Cmd>IndentBlanklineToggle!<CR>", desc = "Toggle Aerial" } },
		init = function()
			vim.g.indent_blankline_enabled = false -- disable by default for toggle
		end,
		config = true,
	},

	-- hightlight word under cursor
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 300,
				providers = { "lsp", "treesitter" },
				filetype_denylist = { "oil", "telescope", "qf" },
				min_count_to_highlight = 2,
			})
			vim.keymap.set("n", "<leader>vw", "<Cmd>IlluminateToggle<Cr>")
		end,
	},

	-- pretty fold
	{
		"anuvyklack/pretty-fold.nvim",
		config = true,
	},

	{
		"jackMort/pommodoro-clock.nvim",
		enabled = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		config = true,
	},

	-- TODO: check out minimap
	-- mouse click movement: https://github.com/gorbit99/codewindow.nvim/issues/37
}