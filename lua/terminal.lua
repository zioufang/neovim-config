vim.cmd([[
function! ToggleTerm(termname)
	let pane = bufwinnr(a:termname)
	let buf = bufexists(a:termname)
	if pane > 0
		exe pane . "wincmd c"
	elseif buf > 0
		exe "botright new"
		exe "resize 25"
		exe "buffer " . a:termname
		exe "normal! i"
	else
		" if is a git repo, then use project root folder
		" else use original vim path
		try
			exe ":cd %:h | exe 'cd ' . fnameescape(get(systemlist('git rev-parse --show-toplevel'), 0))"
		catch
			echo "This is NOT a git repo"
		endtry
		exe "botright new"
		exe "resize 25"
		:terminal
		exe "f " a:termname
		exe "normal! i"
	endif
endfunction
]])
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])

vim.keymap.set({ "n", "t" }, "<C-space>", "<Cmd>call ToggleTerm('main')<Cr>")

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-W><C-h>", opts)
	vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-W><C-j>", opts)
	vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-W><C-k>", opts)
	vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-W><C-l>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
