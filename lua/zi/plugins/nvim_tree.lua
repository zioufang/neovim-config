return {
	"nvim-tree/nvim-tree.lua",
	keys = { { "<leader>t", "<Cmd>NvimTreeToggle<Cr>", desc = "Toggle NvimTree" } },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		hijack_netrw = false, -- using oil
		respect_buf_cwd = true,
		sync_root_with_cwd = true,
		view = {
			mappings = {
				custom_only = false,
				list = {
					{ key = "gh", action = "toggle_dotfiles" },
					{ key = "p", action = "preview" },
				},
			},
		},
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		git = { enable = true },
		filters = { dotfiles = true },
		actions = {
			open_file = { window_picker = { enable = false } }, -- open file in the last window
		},
	},
}
