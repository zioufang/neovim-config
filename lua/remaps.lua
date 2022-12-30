vim.g.mapleader = " "

vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

-- save file
vim.keymap.set("n", "<C-s>", ":update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
vim.keymap.set("i", "<C-s>", "<Esc>:update<Cr>")

vim.keymap.set("n", "<C-c>", ":close<Cr>", { silent = true }) -- close will not close the last window

-- hit '/' highlights then enter search mode
vim.keymap.set("n", "/", ":set hls<Cr>/")

-- vim.keymap.set("n", "<leader>s", ":.,$s///gc<Left><Left><Left><Left>")
vim.keymap.set("n", "<leader>s", ":set hls<Cr>:.,$S///gc<Left><Left><Left><Left>") -- Subvert from vim-abolish

vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")

vim.keymap.set("n", "\\", ":vert sb<Cr>")
--
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- toggle highlight
vim.keymap.set("n", "<leader>h", ":set hls!<Cr>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<Cr>")

-- use system clipboard
vim.keymap.set({ "n", "v" }, "y", '"+y')
vim.keymap.set({ "n", "v" }, "p", '"+p')
vim.keymap.set({ "n", "v" }, "d", '"+d')
vim.keymap.set("n", "Y", '"+y$')
vim.keymap.set("n", "D", '"+D')

-- " c and x to blackhole
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

vim.keymap.set("i", "{{", "{<Cr>}<Esc>O")
vim.keymap.set("i", '""', '""<Left>')

vim.keymap.set("v", ">", "^o^><Esc>gv")
vim.keymap.set("v", "<", "0o0<<Esc>gv")

-- terminal
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-W><C-h>", opts)
	vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-W><C-j>", opts)
	vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-W><C-k>", opts)
	vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-W><C-l>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
