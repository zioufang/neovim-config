-- [[ Setting options ]]
-- See `:help vim.opt`
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.showmode = false -- disable the redundant show mode on the last line
vim.opt.lazyredraw = true -- better macro performance
vim.opt.clipboard = "unnamedplus"

vim.opt.wildmode = "longest,list,full"
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- highlight line number only for cursorline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- mouse is disabled in insert mode
vim.opt.mouse = "nv"

vim.opt.splitbelow = true
vim.opt.splitright = true
-- TODO: enable when the feature is released
-- vim.opt.splitkeep = "screen" -- keep screen after split

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true

-- auto shrink cmd
vim.opt.cmdheight = 0
-- ignorecase while searching, use \C in the end to enforce case-sensitivity
vim.opt.ignorecase = true
-- noignorecase in insert for autocompletion
vim.cmd("au InsertEnter * set noignorecase")
vim.cmd("au InsertLeave * set ignorecase")

vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = "auto:1"
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- Set colorscheme
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,noinsert" -- autoselect the first entry in autocompletion
-- vim.opt.iskeyword:remove({ "_" }) -- _ will be treated as a word('w' not 'W') boundry  check :help word

-- Folding
vim.opt.foldlevel = 99 -- unfold everything reading a new buffer
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- DEBUG: run `:verbose set formatoptions`
-- showed ftplugin rust/lua.vim etc. was overwriting this
-- have to use autocmd to be the last one to set this option
vim.cmd("au BufEnter * set formatoptions-=cro") --'cro' disable auto comment

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- session
vim.cmd([[set sessionoptions+=resize]])

-- replace netrw with the default explorer e.g. lir.nvim
-- see |netrw-noload|
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
