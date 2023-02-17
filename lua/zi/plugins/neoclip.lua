return {
	-- better clilpboard management
	"AckslD/nvim-neoclip.lua",
	event = "VeryLazy",
	config = function()
		require("neoclip").setup({
			history = 20,
			default_register = "+",
			keys = {
				telescope = {
					i = {
						select = "<c-y>",
						paste = "<cr>",
						paste_behind = "<c-p>",
						replay = "<c-q>", -- replay a macro
						delete = "<c-x>", -- delete an entry
						custom = {},
					},
					n = {
						select = "y",
						paste = "p",
						paste_behind = { "<c-p>", "P" },
						replay = "q",
						delete = "d",
						custom = {},
					},
				},
			},
		})
		require("telescope").load_extension("neoclip")
	end,
}
