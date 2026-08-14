return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<Cmd>UndotreeToggle<Cr>" },
		},
		init = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_ShortIndicators = 1
		end,
	},
}
