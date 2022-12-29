-- rose-pine
vim.o.background = "dark"

require('rose-pine').setup({})

require("gruvbox").setup({
  contrast = "hard",
})

vim.g.gruvbox_material_background = 'hard'

vim.cmd([[colorscheme gruvbox-material]])
