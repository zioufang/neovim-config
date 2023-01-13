vim.g.mapleader = " "

-- open lazygit on cwd in a newtab
vim.keymap.set("n", "<leader><leader>", "<Cmd>tabnew | term lazygit<Cr>i")

-- telescope
local telescope = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy({})
local zilescope = require("zilescope")

vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fd", telescope.buffers, {})
vim.keymap.set("n", "<leader>fr", telescope.oldfiles, {})
vim.keymap.set("n", "<leader>fc", telescope.command_history, {})
vim.keymap.set("n", "<leader>ft", telescope.resume, {})
vim.keymap.set("n", "<leader>fy", "<Cmd>Telescope neoclip<Cr>", {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})
-- some keymaps are defined in lsp.lua, to utilize on_attach
vim.keymap.set("n", "<leader>fe", function()
	telescope.diagnostics({ bufnr = 0 })
end, {})
vim.keymap.set("n", "<leader>fE", telescope.diagnostics, {})

vim.keymap.set("n", "<leader>p", function()
	zilescope.fd_projects(ivy)
end, {})
vim.api.nvim_create_user_command("ZiFdProjects", function()
	zilescope.fd_projects(ivy)
end, {})

vim.keymap.set("n", "<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>b", telescope.current_buffer_fuzzy_find, {})

-- lsp
-- See `:h vim.lsp.*`
local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, bufopts)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, bufopts)
vim.keymap.set("n", "<leader>le", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", bufopts) -- TOOD: might be a better way
vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>lr", telescope.lsp_references, {})
-- rust tools specific defined in rust_tools.lua
vim.keymap.set("n", "<leader>lh", "<Cmd>RustSetInlayHints<Cr>", {})
vim.keymap.set("n", "<leader>lH", "<Cmd>RustUnsetInlayHints<Cr>", {})

-- git, more keymaps defined in gitsigns
vim.keymap.set("n", "<leader>gc", telescope.git_branches, {})

-- folding
vim.keymap.set("n", "<leader>z", "za", {})
vim.keymap.set("n", "<leader>vf", "<Cmd>loadview<Cr>", {})
vim.keymap.set("n", "<leader>vF", "<Cmd>mkview<Cr>", {})

-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

-- vim.keymap.set("n", "<C-c>", ":close<Cr>", { silent = true }) -- close will not close the last window

-- hit '/' highlights then enter search mode
vim.keymap.set("n", "/", ":set hls<Cr>/")

-- vim.keymap.set("n", "<leader>s", ":.,$s///gc<Left><Left><Left><Left>")
vim.keymap.set("n", "<leader>s", ":set hls<Cr>:.,$S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish
vim.keymap.set("n", "<leader>S", ":set hls<Cr>:%S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish

-- vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
-- vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
-- vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
-- vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
--
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")

vim.keymap.set("n", "<leader>w", "<C-W>=")

vim.keymap.set("n", "\\", ":vert sb<Cr><C-w>=")
--
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- toggle highlight
vim.keymap.set("n", "<leader>h", "<Cmd>set hls!<Cr>")

vim.keymap.set("n", "<leader>cd", "<Cmd>cd %:p:h<Cr>")
-- copy correct dir to clipboard
vim.keymap.set("n", "<leader>cp", '<Cmd>let @+ = expand("%:p:h")<Cr>')
-- chmod a+x on current buffer
vim.keymap.set("n", "<leader>cx", "<Cmd>:!chmod a+x %<Cr>")

-- replacing gx, open url in browser, since netrw is generally disabled
vim.keymap.set("n", "gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

vim.keymap.set("n", "Y", '"+y$')

-- " c and x to blackhole
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

vim.keymap.set("v", ">", "^o^><Esc>gv")
vim.keymap.set("v", "<", "0o0<<Esc>gv")

-- quickfix
vim.cmd([[
function! ToggleQuickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
]])
vim.cmd([[
function! ToggleVertQuickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        vert copen
    else
        cclose
    endif
endfunction
]])
vim.keymap.set("n", "<leader>qq", "<Cmd>call ToggleQuickfix()<Cr>")
vim.keymap.set("n", "<leader>qv", "<Cmd>call ToggleVertQuickfix()<Cr>")
vim.keymap.set("n", "<leader>qj", "<Cmd>silent! cnewer<Cr>")
vim.keymap.set("n", "<leader>qk", "<Cmd>silent! colder<Cr>")
vim.keymap.set("n", "<leader>qi", require("replacer").run, { silent = true })

-- closing all buffers referenced in the qf list (after doing search replace etc.)
-- cdo bd

-- alt key mapping
vim.keymap.set("n", "<A-s>", "<Cmd>silent! update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
vim.keymap.set("i", "<A-s>", "<Esc>:silent! update<Cr>")
vim.keymap.set("n", "<A-x>", "<Cmd>Telescope command_center<Cr>")

-- Cmd Copy Paste for MacOs in neovide or other GUI
vim.keymap.set("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.keymap.set({ "!", "t", "v" }, "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.keymap.set("v", "<D-c>", '"+y<Cr>', { noremap = true, silent = true })
