local builtin = require("telescope.builtin")
local lga_actions = require("telescope-live-grep-args.actions")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fd", builtin.buffers, {})
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
vim.keymap.set("n", "<leader>fj", builtin.jumplist, {})
vim.keymap.set("n", "<leader>ft", builtin.resume, {})
vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>fp", builtin.registers, {})

-- lsp + diagnostics starting
vim.keymap.set("n", "<leader>fe", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>jr", builtin.lsp_references, {})

-- vim.keymap.set("n", "<leader>r", builtin.live_grep, {})
vim.keymap.set("n", "<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>R", builtin.current_buffer_fuzzy_find, {})

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		scroll_strategy = "limit", -- or cycle
		layout_config = { prompt_position = "top", height = 0.95, width = 0.95 },
		mappings = {
			i = {
				-- delete buffer, can multi select with Tab first
				["<C-x>"] = require("telescope.actions").delete_buffer,
				["<C-s>"] = require("telescope.actions").select_horizontal,
				["<C-d>"] = require("telescope.actions").results_scrolling_down,
				["<C-u>"] = require("telescope.actions").results_scrolling_up,
			},
			n = {
				["<C-n>"] = require("telescope.actions").move_selection_next,
				["<C-p>"] = require("telescope.actions").move_selection_previous,
				["<C-s>"] = require("telescope.actions").select_horizontal,
				["<C-d>"] = require("telescope.actions").results_scrolling_down,
				["<C-u>"] = require("telescope.actions").results_scrolling_up,
			},
		},
	},
	pickers = {
		git_files = {
			theme = "ivy",
			preview = { hide_on_startup = true },
		},
		find_files = {
			theme = "ivy",
			preview = { hide_on_startup = true },
		},
		buffers = {
			theme = "ivy",
			preview = { hide_on_startup = true },
		},
		oldfiles = {
			theme = "ivy",
			preview = { hide_on_startup = true },
		},
		command_history = {
			theme = "ivy",
			preview = { hide_on_startup = true },
		},
	},

	extensions = {
		-- fzf EXACT match syntax
		-- 'wild	include wild
		-- ^music	start with music
		-- .mp3$	end with .mp3
		-- !fire	do not include fire
		-- !^music	do not start with music
		-- !.mp3$	do not end with .mp3
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		live_grep_args = {
			auto_quoting = false, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
		},
		project = {
			base_dirs = {
				{ "~/projects", max_depth = 3 },
			},
			theme = "ivy",
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("live_grep_args")

require("telescope").load_extension("project")
vim.keymap.set("n", "<leader>p", ":Telescope project display_type=full<Cr>")
