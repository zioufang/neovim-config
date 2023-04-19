local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local fmt = string.format

local function get_visible_terminal_buffer()
	-- Get all the windows in the current tabpage
	local win_ids = vim.api.nvim_tabpage_list_wins(0)
	print(vim.inspect(win_ids))

	for _, win_id in ipairs(win_ids) do
		-- Get the buffer associated with the window
		local bufnr = vim.api.nvim_win_get_buf(win_id)

		-- Get the buffer's filetype
		local buf_ft = vim.api.nvim_buf_get_option(bufnr, "buftype")
		print(buf_ft)

		-- Check if the filetype is 'terminal'
		if buf_ft == "terminal" then
			return win_id
		end
	end

	return 0
end

-- toggle term with a specific buf name
-- assuming max of one visible term buffer per tab
-- TODO: remember cursor position
local function toggle_term(buf_name)
	-- if any visible terminal exists
	local window_id = get_visible_terminal_buffer()

	-- only check terminal buffer with a specific name
	-- local window_id = fn.win_getid(fn.bufwinnr(buf_name))

	local existed = fn.bufexists(buf_name)
	print(window_id)

	if window_id > 0 then
		api.nvim_win_hide(window_id)
	else
		if existed < 1 then -- if no existing term
			cmd(fmt("botright new")) -- create a new buffer
			cmd("terminal")
			-- rename the buffer to buf_name
			cmd(fmt("file %s", buf_name))
		else
			cmd(fmt("botright split %s", buf_name)) -- bring back the term buffer
		end
		cmd("resize 30")
		cmd("normal! i") -- enter insert mode
	end
end

-- toggle term based on dir name of the current working directory
vim.keymap.set({ "n", "t" }, "<C-space>", function()
	local cwd = fn.getcwd()
	local names = vim.split(cwd, "/")
	local name = names[#names]
	toggle_term("term_" .. name)
end)

-- function _G.set_terminal_keymaps()
-- 	local opts = { buffer = 0 }
-- 	vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-W><C-h>", opts)
-- 	vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-W><C-j>", opts)
-- 	vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-W><C-k>", opts)
-- 	vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-W><C-l>", opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
vim.cmd([[
augroup zi_term_nonumber
autocmd!
autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
]])

-- auto close terminal that exited with 0, but keep it open if exit code is non-zero
-- Do not show [Process exited with 0] and quit finished terminals traightaway
-- https://github.com/neovim/neovim/issues/14986
-- WARN: would leave a ghost window with floating terminal
vim.cmd([[
augroup zi_term_auto_close
autocmd!
autocmd TermClose * if !v:event.status | exe 'silent! bdelete! '..expand('<abuf>') | endif
augroup END
]])
