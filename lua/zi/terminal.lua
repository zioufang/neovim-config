local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local fmt = string.format
-- toggle term with a specific buf name
local function toggle_term(buf_name)
	local window_id = fn.win_getid(fn.bufwinnr(buf_name))
	local existed = fn.bufexists(buf_name)

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
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])

-- Do not show [Process exited with 0] and quit finished terminals traightaway
-- https://github.com/neovim/neovim/issues/14986
-- WARN: would leave a ghost window with floating terminal
vim.cmd([[autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif]])
