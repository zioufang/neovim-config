vim.g.mapleader = " "

-- save file
vim.keymap.set("n", "<C-s>", ":w<Cr>")
vim.keymap.set("i", "<C-s>", "<C-O>:w<Cr>")

-- hit '/' highlights then enter search mode
vim.keymap.set("n", "/", ":set hls<Cr>/")

vim.keymap.set("n", "<leader>s", ":.,$s///gc<Left><Left><Left><Left>")

vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
--
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- " c and x to blackhole
vim.keymap.set("n", "c", "\"_c")
vim.keymap.set("n", "C", "\"_C")
vim.keymap.set("n", "x", "\"_x")
vim.keymap.set("n", "X", "\"_X")
