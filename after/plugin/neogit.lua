require("neogit").setup({
	mappings = {
		-- modify status buffer mappings
		status = {
			["p"] = "PushPopup",
			["f"] = "PullPopup", -- fetch
			["z"] = "StashPopup", -- fetch
			["P"] = "",
		},
	},
	integrations = {
		diffview = true,
	},
})

vim.keymap.set("n", "<leader><leader>", ":Neogit<Cr>")
