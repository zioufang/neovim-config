-- [[ Setting options ]]
-- See `:help vim.opt`
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false -- disable the redundant show mode on the last line
vim.opt.cursorline = true
vim.opt.lazyredraw = true -- better macro performance

vim.opt.wildmode = "longest,list,full"
-- Set highlight on search with the remapped '/'
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enable mouse mode
vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- ignorecase while searching, use \C in the end to enforce case-sensitivity
vim.opt.ignorecase = true
-- noignorecase in insert for autocompletion
vim.cmd("au InsertEnter * set noignorecase")
vim.cmd("au InsertLeave * set ignorecase")

vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = "no" -- sign in nvim-scrollbar
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- Set colorscheme
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,noinsert" -- autoselect the first entry in autocompletion
vim.opt.iskeyword:remove({ "_" }) -- _ will be treated as a word('w' not 'W') boundry  check :help word

-- DEBUG: run `:verbose set formatoptions`
-- showed ftplugin rust/lua.vim etc. was overwriting this
-- have to use autocmd to be the last one to set this option
vim.cmd("au BufEnter * set formatoptions-=cro") --'cro' disable auto comment

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- replace netrw with the default explorer e.g. lir.nvim
-- see |netrw-noload|
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable subsitute preview for abolish via trace
vim.g.traces_abolish_integration = 1
