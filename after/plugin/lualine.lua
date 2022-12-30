require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function(str)
				return str:sub(1, 1)
			end,
		} },
		lualine_b = {
			{
				"filename",
				-- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				path = 1,
				symbols = {
					unnamed = "[Home]", -- Text to show for unnamed buffers.
				},
			},
		}, -- full path
		lualine_c = { { "aerial", dense = true } },
		lualine_x = {
			"diagnostics",
			"diff",
			{
				"filetype",
				icon_only = true,
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				symbols = {
					unnamed = "[Home]",
				},
			},
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
