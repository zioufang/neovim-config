-- normal mapping
local function keymap(keys, cmd, modes, opts)
  opts = opts or { noremap = true, silent = true }
  modes = modes or { "n" }
  vim.keymap.set(modes, keys, cmd, opts)
end

vim.g.mapleader = " "

-- open lazygit on cwd in a newtab
keymap("<leader><leader>", "<Cmd>tabnew | term lazygit<Cr>i")

-- universal closing keymap in normal mode
-- 1. will not close the last window
-- 2. will not save modified buffer (should use `ZZ` instead)
keymap("<C-c>", "<Cmd>silent! close!<Cr>")

-- Lazy.nvim UI
vim.keymap.set("n", "<leader>l", "<Cmd>Lazy<Cr>")

-- telescope
local telescope = require("telescope.builtin")

keymap("<leader>ff", function()
  telescope.oldfiles({ only_cwd = true })
end)
keymap("<leader>fr", telescope.oldfiles)

keymap("<leader>fp", telescope.find_files)
keymap("<leader>fd", function()
  telescope.buffers({ ignore_current_buffer = true, sort_mru = true, only_cwd = true }) -- sort all buffers by recency
end)
keymap("<leader>fb", function()
  telescope.buffers({ ignore_current_buffer = true, sort_mru = true, only_cwd = false }) -- sort all buffers by recency
end)
keymap("<leader>fc", telescope.command_history)
keymap("<leader>ft", telescope.resume)
-- some keymaps are defined in lsp.lua, to utilize on_attach
keymap("<leader>fe", function()
  telescope.diagnostics({ bufnr = 0 })
end)
keymap("<leader>fE", telescope.diagnostics)

keymap("<leader>R", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap("<leader>r", function()
  telescope.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" })
end)
keymap("<leader>b", telescope.current_buffer_fuzzy_find)

keymap("<leader>p", function() require("zi.switch_repo").fd_projects(require("telescope.themes").get_ivy()) end)
keymap("<leader>P", "<Cmd>Telescope repo<CR>")


-- docs
keymap("<leader>fhv", telescope.help_tags)
keymap("<leader>fht", "<Cmd>Telescope terraform_doc full_name=hashicorp/google<CR>")

-- lsp
-- See `:h vim.lsp.*`
keymap("gd", vim.lsp.buf.definition)
keymap("gD", "<Cmd>vert sb<Cr><Cmd>lua vim.lsp.buf.definition()<Cr>")
keymap("gr", vim.lsp.buf.references)
keymap("K", vim.lsp.buf.hover)
keymap("<leader>ja", vim.lsp.buf.code_action)
keymap("<leader>js", vim.lsp.buf.signature_help)
keymap("<leader>jR", vim.lsp.buf.rename)
keymap("<leader>jf", vim.lsp.buf.format)
keymap("<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>") -- TOOD: might be a better way
keymap("<leader>jj", vim.diagnostic.open_float)
keymap("<leader>jn", vim.diagnostic.goto_next)
keymap("<leader>jp", vim.diagnostic.goto_prev)
keymap("<leader>jr", telescope.lsp_references)
-- rust tools specific defined in rust_tools.lua
keymap("<leader>jh", "<Cmd>RustSetInlayHints<Cr>")
keymap("<leader>jH", "<Cmd>RustUnsetInlayHints<Cr>")

-- git, more keymaps defined in git
keymap("<leader>gc", telescope.git_branches)

-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])
vim.cmd([[:command! Vs so ~/.config/nvim/init.lua]])

-- hit '/' highlights then enter search mode
keymap("/", ":set hls<Cr>/")

-- need to disable `silent` for Cmd without Cr, otherwise the text will not show up  in cmdlin
keymap("<leader>s", "<Cmd>set hls<Cr>:.,$S///gc" .. string.rep("<Left>", 4), "n", { silent = false }) -- Subvert from vim-abolish
keymap("<leader>S", "<Cmd>set hls<Cr>:%S///gc" .. string.rep("<Left>", 4), "n", { silent = false })   -- Subvert from vim-abolish

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
  local cmd = "tabnew | term glow " ..
      path ..
      " && exit 1" -- HACK: forcing to exit 1 so the term auto close (defined in terminal.lua) doesn't happen
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

-- useful when combined with rg a word in cwd
local function cd_current_buf()
  local cwd = vim.fn.expand("%:p:h")
  cwd = cwd:gsub("oil://", "")
  vim.cmd("cd " .. cwd)
end
keymap("<leader>cd", cd_current_buf)
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
keymap("<leader>qI", require("replacer").run)       -- rename file in quickfix

-- closing all buffers referenced in the qf list (after doing search replace etc.)
-- cdo bd

keymap("<C-h>", "<CMD>NavigatorLeft<CR>", { "n", "t" })
keymap("<C-l>", "<CMD>NavigatorRight<CR>", { "n", "t" })
keymap("<C-k>", "<CMD>NavigatorUp<CR>", { "n", "t" })
keymap("<C-j>", "<CMD>NavigatorDown<CR>", { "n", "t" })

-- GNU readline behaviour in cmdline
keymap("<C-b>", "<S-Left>", "c", { silent = false })
keymap("<C-f>", "<S-Right>", "c", { silent = false })
keymap("<C-a>", "<C-b>", "c", { silent = false })

keymap("<C-x><C-e>", "<C-f>i", "c", { silent = false }) -- enter command line window with insert mode

-- alt key mapping
keymap("<A-s>", "<Cmd>update<Cr>") -- update doesnt overwrite if file is unchanged like :w would do
keymap("<A-s>", "<Esc><Cmd>update<Cr>", "i")
keymap("<A-x>", "<Cmd>Telescope command_center<Cr>")

-- Cmd Copy Paste for MacOs in neovide or other GUI
keymap("<D-v>", "+p<CR>", "")
keymap("<D-v>", "<C-R>+", { "!", "t", "v" })
keymap("<D-c>", '"+y<Cr>', "v")

-- Cmd+c is remapped to Alt-Shift-C in terminal app
keymap("<A-C>", '"+y<Cr>', { "v" })
