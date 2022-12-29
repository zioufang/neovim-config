-- [[ Setting options ]]
-- See `:help vim.opt`
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
-- noignorecase in insert for autocompletion
vim.cmd("au InsertEnter * set noignorecase")
vim.cmd("au InsertLeave * set ignorecase")
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.isfname:append("@-@") -- TODO: ??

-- Set colorscheme
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,noinsert'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.nojoinspaces = true           -- no extra space after '.' when joining lines

-- replace netrw with the default explorer e.g. lir.nvim
-- see |netrw-noload|
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
