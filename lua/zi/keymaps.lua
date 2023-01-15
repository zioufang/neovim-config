-- normal mapping
local function keymap(keys, cmd, modes, opts)
	local opts = opts or { noremap = true, silent = true }
	local modes = modes or { "n" }
	vim.keymap.set(modes, keys, cmd, opts)
end

vim.g.mapleader = " "

-- open lazygit on cwd in a newtab
keymap("<leader><leader>", "<Cmd>tabnew | term lazygit<Cr>i")

-- universal closing keymap in normal mode
-- but will not close the last window
keymap("<C-c>", "<Cmd>silent! close!<Cr>")

-- telescope
local telescope = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy({})
local zilescope = require("zi/zilescope")

keymap("<leader>ff", telescope.find_files)
keymap("<leader>fd", telescope.buffers)
keymap("<leader>fr", telescope.oldfiles)
keymap("<leader>fc", telescope.command_history)
keymap("<leader>ft", telescope.resume)
keymap("<leader>fy", "<Cmd>Telescope neoclip<Cr>")
keymap("<leader>fh", telescope.help_tags)
-- some keymaps are defined in lsp.lua, to utilize on_attach
keymap("<leader>fe", function()
	telescope.diagnostics({ bufnr = 0 })
end)
keymap("<leader>fE", telescope.diagnostics)

keymap("<leader>p", function()
	zilescope.fd_projects(ivy)
end)
vim.api.nvim_create_user_command("ZiFdProjects", function()
	zilescope.fd_projects(ivy)
end, {})

keymap("<leader>R", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap("<leader>r", function()
	telescope.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" })
end)
keymap("<leader>b", telescope.current_buffer_fuzzy_find)

-- lsp
-- See `:h vim.lsp.*`
keymap("gd", vim.lsp.buf.definition)
keymap("gr", vim.lsp.buf.references)
keymap("K", vim.lsp.buf.hover)
keymap("<leader>la", vim.lsp.buf.code_action)
keymap("<leader>ls", vim.lsp.buf.signature_help)
keymap("<leader>lR", vim.lsp.buf.rename)
keymap("<leader>lf", vim.lsp.buf.format)
keymap("<leader>le", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>") -- TOOD: might be a better way
keymap("<leader>ll", vim.diagnostic.open_float)
keymap("<leader>ln", vim.diagnostic.goto_next)
keymap("<leader>lp", vim.diagnostic.goto_prev)
keymap("<leader>lr", telescope.lsp_references)
-- rust tools specific defined in rust_tools.lua
keymap("<leader>lh", "<Cmd>RustSetInlayHints<Cr>")
keymap("<leader>lH", "<Cmd>RustUnsetInlayHints<Cr>")

-- git, more keymaps defined in gitsigns
keymap("<leader>gc", telescope.git_branches)

-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

-- hit '/' highlights then enter search mode
keymap("/", ":set hls<Cr>/")

keymap("<leader>s", ":set hls<Cr>:.,$S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish
keymap("<leader>S", ":set hls<Cr>:%S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish

-- vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
-- vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
-- vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
-- vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
--
keymap("<C-h>", "<CMD>NavigatorLeft<CR>", { "n", "t" })
keymap("<C-l>", "<CMD>NavigatorRight<CR>", { "n", "t" })
keymap("<C-k>", "<CMD>NavigatorUp<CR>", { "n", "t" })
keymap("<C-j>", "<CMD>NavigatorDown<CR>", { "n", "t" })

keymap("<leader>w", "<C-W>=")

keymap("\\", ":vert sb<Cr><C-w>=")
--
keymap("Q", "@q")
keymap("H", "^")
keymap("L", "$")

-- folding
keymap("<leader>z", "za")
keymap("<leader>vf", "<Cmd>loadview<Cr>")
keymap("<leader>vF", "<Cmd>mkview<Cr>")

-- markdown preview in glow
function _G.GlowMarkdown()
	local path = vim.api.nvim_buf_get_name(0)
	local cmd = "tabnew | term glow " .. path .. " && exit 1" -- HACK: forcing to exit 1 so the term auto close (defined in terminal.lua) doesn't happen
	vim.cmd(cmd)
end
keymap("<leader>vm", GlowMarkdown)

-- toggle highlight
keymap("<leader>h", "<Cmd>set hls!<Cr>")
-- toggle cmdheight, good for recording macro
local function toggle_cmdline()
	vim.pretty_print(vim.opt.cmdheight)
	if vim.opt.cmdheight:get() > 0 then
		vim.opt.cmdheight = 0
	else
		vim.opt.cmdheight = 1
	end
end
keymap("<leader>vc", toggle_cmdline)

keymap("<leader>cd", "<Cmd>cd %:p:h<Cr>")
-- copy correct dir to clipboard
keymap("<leader>cp", '<Cmd>let @+ = expand("%:p:h")<Cr>')
-- chmod a+x on current buffer
keymap("<leader>cx", "<Cmd>!chmod a+x %<Cr>")

-- replacing gx, open url in browser, since netrw is generally disabled
keymap("gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

keymap("Y", '"+y$')

-- " c and x to blackhole
keymap("c", '"_c')
keymap("C", '"_C')
keymap("x", '"_x')
keymap("X", '"_X')

keymap(">", "^o^><Esc>gv", "v")
keymap("<", "0o0<<Esc>gv", "v")

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
keymap("<leader>qq", "<Cmd>call ToggleQuickfix()<Cr>")
keymap("<leader>qv", "<Cmd>call ToggleVertQuickfix()<Cr>")
keymap("<leader>qj", "<Cmd>silent! cnewer<Cr>")
keymap("<leader>qk", "<Cmd>silent! colder<Cr>")
keymap("<leader>qi", function()
	require("replacer").run({ rename_files = false }) -- dont rename file in quickfix
end)

-- closing all buffers referenced in the qf list (after doing search replace etc.)
-- cdo bd

-- cmdline key maps

-- alt key mapping
keymap("<A-s>", "<Cmd>update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
keymap("<A-s>", "<Esc><Cmd>update<Cr>", "i")
keymap("<A-x>", "<Cmd>Telescope command_center<Cr>")

-- Cmd Copy Paste for MacOs in neovide or other GUI
keymap("<D-v>", "+p<CR>", "")
keymap("<D-v>", "<C-R>+", { "!", "t", "v" })
keymap("<D-c>", '"+y<Cr>', "v")
