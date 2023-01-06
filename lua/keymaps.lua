vim.g.mapleader = " "

-- telescope
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<A-x>", "<Cmd>Telescope command_center<Cr>")

vim.keymap.set("n", "<leader>ff", telescope.git_files, {})
vim.keymap.set("n", "<leader>fF", telescope.find_files, {})
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

vim.keymap.set("n", "<leader>p", ":Telescope projects<Cr>")

vim.keymap.set("n", "<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>b", telescope.current_buffer_fuzzy_find, {})

--lsp
-- vim.keymap.set("n", "<leader>jl", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>ll", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>lr", telescope.lsp_references, {})

vim.keymap.set("n", "<leader>gc", telescope.git_branches, {})

-- rust tools
vim.keymap.set("n", "<leader>lh", function()
	require("rust-tools").inlay_hints.set()
end, {})
vim.keymap.set("n", "<leader>lh", function()
	require("rust-tools").inlay_hints.unset()
end, {})

-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

-- save file
vim.keymap.set("n", "<C-s>", ":update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
vim.keymap.set("i", "<C-s>", "<Esc>:update<Cr>")

-- vim.keymap.set("n", "<C-c>", ":close<Cr>", { silent = true }) -- close will not close the last window

-- hit '/' highlights then enter search mode
vim.keymap.set("n", "/", ":set hls<Cr>/")

-- vim.keymap.set("n", "<leader>s", ":.,$s///gc<Left><Left><Left><Left>")
vim.keymap.set("n", "<leader>s", ":set hls<Cr>:.,$S///gc<Left><Left><Left><Left>") -- Subvert from vim-abolish
vim.keymap.set("n", "<leader>S", ":set hls<Cr>:cdo! .,$S///gc<Left><Left><Left><Left> | update")

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
