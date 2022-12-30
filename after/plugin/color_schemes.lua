vim.o.background = "dark"

vim.g.gruvbox_material_background = "hard"

vim.cmd([[colorscheme gruvbox-material]])

-- Custom color needs to be placed after the colorscheme
-- https://jonasjacek.github.io/colors/
vim.cmd([[highlight CursorLine ctermbg=240 guibg=#3a3a3a]])
vim.cmd([[autocmd InsertEnter * highlight CursorLine ctermbg=235 guibg=#282828]])
vim.cmd([[autocmd InsertLeave * highlight CursorLine ctermbg=237 guibg=#3a3a3a]])
vim.cmd([[
augroup NoCursorLine
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END
]])
