-- normal mapping
local function nmap(keys, cmd, opts)
	local opts = opts or { noremap = true, silent = true }
	vim.keymap.set("n", keys, cmd, opts)
end

vim.g.mapleader = " "

-- open lazygit on cwd in a newtab
nmap("<leader><leader>", "<Cmd>tabnew | term lazygit<Cr>i")

-- telescope
local telescope = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy({})
local zilescope = require("zi/zilescope")

nmap("<leader>ff", telescope.find_files)
nmap("<leader>fd", telescope.buffers)
nmap("<leader>fr", telescope.oldfiles)
nmap("<leader>fc", telescope.command_history)
nmap("<leader>ft", telescope.resume)
nmap("<leader>fy", "<Cmd>Telescope neoclip<Cr>")
nmap("<leader>fh", telescope.help_tags)
-- some keymaps are defined in lsp.lua, to utilize on_attach
nmap("<leader>fe", function()
	telescope.diagnostics({ bufnr = 0 })
end, {})
nmap("<leader>fE", telescope.diagnostics)

nmap("<leader>p", function()
	zilescope.fd_projects(ivy)
end, {})
vim.api.nvim_create_user_command("ZiFdProjects", function()
	zilescope.fd_projects(ivy)
end, {})

nmap("<leader>R", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
nmap("<leader>r", function()
	telescope.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" })
end)
nmap("<leader>b", telescope.current_buffer_fuzzy_find, {})

-- lsp
-- See `:h vim.lsp.*`
nmap("gd", vim.lsp.buf.definition)
nmap("gr", vim.lsp.buf.references)
nmap("K", vim.lsp.buf.hover)
nmap("<leader>la", vim.lsp.buf.code_action)
nmap("<leader>ls", vim.lsp.buf.signature_help)
nmap("<leader>lR", vim.lsp.buf.rename)
nmap("<leader>lf", vim.lsp.buf.format)
nmap("<leader>le", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>") -- TOOD: might be a better way
nmap("<leader>ll", vim.diagnostic.open_float)
nmap("<leader>ln", vim.diagnostic.goto_next)
nmap("<leader>lp", vim.diagnostic.goto_prev)
nmap("<leader>lr", telescope.lsp_references)
-- rust tools specific defined in rust_tools.lua
nmap("<leader>lh", "<Cmd>RustSetInlayHints<Cr>")
nmap("<leader>lH", "<Cmd>RustUnsetInlayHints<Cr>")

-- git, more keymaps defined in gitsigns
nmap("<leader>gc", telescope.git_branches)

-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

vim.keymap.set("n", "<C-c>", "<Cmd>close<Cr>") -- close will not close the last window

-- hit '/' highlights then enter search mode
nmap("/", ":set hls<Cr>/")

-- vim.keymap.set("n", "<leader>s", ":.,$s///gc<Left><Left><Left><Left>")
nmap("<leader>s", ":set hls<Cr>:.,$S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish
nmap("<leader>S", ":set hls<Cr>:%S///gc" .. string.rep("<Left>", 4)) -- Subvert from vim-abolish

-- vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
-- vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
-- vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
-- vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
--
vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")

nmap("<leader>w", "<C-W>=")

nmap("\\", ":vert sb<Cr><C-w>=")
--
nmap("Q", "@q")
nmap("H", "^")
nmap("L", "$")

-- folding
nmap("<leader>z", "za")
nmap("<leader>vf", "<Cmd>loadview<Cr>")
nmap("<leader>vF", "<Cmd>mkview<Cr>")

-- markdown preview in glow
function _G.GlowMarkdown()
	local path = vim.api.nvim_buf_get_name(0)
	local cmd = "tabnew | term glow " .. path .. " && exit 1" -- HACK: forcing to exit 1 so the term auto close (defined in terminal.lua) doesn't happen
	vim.cmd(cmd)
end
nmap("<leader>vm", GlowMarkdown)

-- toggle highlight
nmap("<leader>h", "<Cmd>set hls!<Cr>")
-- toggle cmdheight, good for recording macro
local function toggle_cmdline()
	vim.pretty_print(vim.opt.cmdheight)
	if vim.opt.cmdheight:get() > 0 then
		vim.opt.cmdheight = 0
	else
		vim.opt.cmdheight = 1
	end
end
nmap("<leader>vc", toggle_cmdline)

nmap("<leader>cd", "<Cmd>cd %:p:h<Cr>")
-- copy correct dir to clipboard
nmap("<leader>cp", '<Cmd>let @+ = expand("%:p:h")<Cr>')
-- chmod a+x on current buffer
nmap("<leader>cx", "<Cmd>:!chmod a+x %<Cr>")

-- replacing gx, open url in browser, since netrw is generally disabled
nmap("gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

nmap("Y", '"+y$')

-- " c and x to blackhole
nmap("c", '"_c')
nmap("C", '"_C')
nmap("x", '"_x')
nmap("X", '"_X')

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
nmap("<leader>qq", "<Cmd>call ToggleQuickfix()<Cr>")
nmap("<leader>qv", "<Cmd>call ToggleVertQuickfix()<Cr>")
nmap("<leader>qj", "<Cmd>cnewer<Cr>")
nmap("<leader>qk", "<Cmd>colder<Cr>")
nmap("<leader>qi", require("replacer").run)

-- closing all buffers referenced in the qf list (after doing search replace etc.)
-- cdo bd

-- alt key mapping
nmap("<A-s>", "<Cmd>update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
vim.keymap.set("i", "<A-s>", "<Esc>update<Cr>")
nmap("<A-x>", "<Cmd>Telescope command_center<Cr>")

-- Cmd Copy Paste for MacOs in neovide or other GUI
vim.keymap.set("", "<D-v>", "+p<CR>")
vim.keymap.set({ "!", "t", "v" }, "<D-v>", "<C-R>+")
vim.keymap.set("v", "<D-c>", '"+y<Cr>')
