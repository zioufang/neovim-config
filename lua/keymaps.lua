vim.g.mapleader = " "

-- telescope
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fd", telescope.buffers, {})
vim.keymap.set("n", "<leader>fr", telescope.oldfiles, {})
vim.keymap.set("n", "<leader>fc", telescope.command_history, {})
vim.keymap.set("n", "<leader>fj", telescope.jumplist, {})
vim.keymap.set("n", "<leader>ft", telescope.resume, {})
-- vim.keymap.set("n", "<leader>fs", telescope.spell_suggest, {})
vim.keymap.set("n", "<leader>fy", telescope.registers, {})

vim.keymap.set("n", "<leader>p", ":Telescope projects<Cr>")

vim.keymap.set("n", "<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>b", telescope.current_buffer_fuzzy_find, {})

vim.keymap.set("n", "<A-x>", "<Cmd>Telescope command_center<Cr>")

--lsp
vim.keymap.set("n", "<leader>fe", telescope.diagnostics, {})

vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>jj", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>jk", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>jR", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>", {}) -- TOOD: might be a better way
vim.keymap.set("n", "<leader>ji", ":LspInfo<Cr>", {})
vim.keymap.set("n", "<leader>jr", telescope.lsp_references, {})

-- rust tools
vim.keymap.set("n", "<leader>lh", "<Cmd>RustSetInlayHints<Cr>")
vim.keymap.set("n", "<leader>lH", "<Cmd>RustUnsetInlayHints<Cr>")

-- custom commands
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
vim.keymap.set("n", "<leader>w", "<C-W>=")

vim.keymap.set("n", "\\", ":vert sb<Cr>")
--
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- toggle highlight
vim.keymap.set("n", "<leader>h", ":set hls!<Cr>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<Cr>")

vim.keymap.set("n", "Y", '"+y$')

-- " c and x to blackhole
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

vim.keymap.set("i", "{{", "{<Cr>}<Esc>O")
vim.keymap.set("i", '""', '""<Left>')

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
vim.keymap.set("n", "<leader>q", "<Cmd>call ToggleQuickfix()<Cr>")
vim.keymap.set("n", "<leader>Q", "<Cmd>call ToggleVertQuickfix()<Cr>")

-- closing all buffers referenced in the qf list (after doing search replace etc.)
-- cdo bd
