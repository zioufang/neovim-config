vim.o.background = "dark"

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

-- sonokai has higher contrast
vim.g.sonokai_better_performance = 1
vim.g.sonokai_style = "shusia" -- espresso
vim.g.sonokai_diagnostic_virtual_text = "colored"

vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("colorscheme sonokai")

-- Custom color needs to be placed after the colorscheme
-- https://jonasjacek.github.io/colors/
vim.cmd([[highlight CursorLine ctermbg=240 guibg=#333333]])
vim.cmd([[autocmd InsertEnter * highlight CursorLine ctermbg=235 guibg=#222222]])
vim.cmd([[autocmd InsertLeave * highlight CursorLine ctermbg=237 guibg=#333333]])
vim.cmd([[
augroup NoCursorLine
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END
]])
