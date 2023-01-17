return {
	{
		"stevearc/aerial.nvim",
		lazy = true,
		keys = { { "<leader>a", "<Cmd>AerialToggle!<CR>", desc = "Toggle Aerial" } },
		opts = {
			highlight_on_hover = true,
			lsp = { update_when_errors = false },
		},
	},
}
