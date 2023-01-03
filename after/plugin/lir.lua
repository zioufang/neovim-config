local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
	show_hidden_files = false,
	ignore = {}, -- { ".DS_Store" "node_modules" } etc.
	devicons_enable = true,
	mappings = {
		["<Cr>"] = actions.edit,
		["<C-s>"] = actions.split,
		["<C-v>"] = actions.vsplit,
		["<C-t>"] = actions.tabedit,

		["-"] = actions.up,
		["q"] = actions.quit,

		["K"] = actions.mkdir,
		["N"] = actions.newfile,
		["R"] = actions.rename,
		["@"] = actions.cd,
		["Y"] = actions.yank_path,
		["."] = actions.toggle_show_hidden,
		["D"] = actions.delete,

		["m"] = function()
			mark_actions.toggle_mark()
			vim.cmd("normal! j")
		end,
		["y"] = clipboard_actions.copy,
		["c"] = clipboard_actions.cut,
		["p"] = clipboard_actions.paste,
	},
	float = {
		winblend = 0,
		curdir_window = {
			enable = false,
			highlight_dirname = false,
		},
	},
	hide_cursor = true,
	on_init = function()
		-- use visual mode
		vim.api.nvim_buf_set_keymap(
			0,
			"x",
			"J",
			':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
			{ noremap = true, silent = true }
		)

		-- echo cwd
		vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
	end,
})

-- press `-` to visit current path
vim.api.nvim_set_keymap("n", "-", [[<Cmd>silent! execute 'e ' .. expand('%:p:h')<CR>]], { noremap = true })

-- press '_' to split open dir
vim.api.nvim_set_keymap(
	"n",
	"_",
	[[<Cmd>silent! vert sb<Cr>:silent! execute 'e ' .. expand('%:p:h')<CR>]],
	{ noremap = true }
)
