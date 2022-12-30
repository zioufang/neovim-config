require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "diagnostics" },
		lualine_c = { "%<%F%*%m%*" }, -- full path
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = { "require'lsp-status'.status()" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
