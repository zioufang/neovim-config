require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = 20,
	open_mapping = [[<C-space>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	-- shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	-- shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = false, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = "horizontal",
	close_on_exit = true, -- close the terminal window when the process exits
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
})
