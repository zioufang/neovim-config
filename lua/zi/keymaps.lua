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

-- Toggles between the current window and the current buffer
-- opened in a new tab page.
vim.cmd([[
function! ToggleWindowMaximized()
  if winnr("$") > 1
  " There are more than one window in this tab
    if exists("b:maximized_window_id")
      call win_gotoid(b:maximized_window_id)
    else
      let b:origin_window_id = win_getid()
      tab sp
      let b:maximized_window_id = win_getid()
    endif
  else
  " This is the only window in this tab
    if exists("b:origin_window_id")
      let l:origin_window_id = b:origin_window_id
      tabclose
      call win_gotoid(l:origin_window_id)
      unlet b:maximized_window_id
      unlet b:origin_window_id
    endif
  endif
endfunction
]])
keymap("<F12>", "<Cmd>call ToggleWindowMaximized()<Cr>")

-- telescope
local telescope = require("telescope.builtin")

-- fa: arieal toggle
keymap("<leader>ff", function()
  telescope.oldfiles({ only_cwd = true })
end)
keymap("<leader>fr", telescope.oldfiles)
keymap("<leader>fb", telescope.current_buffer_fuzzy_find)
keymap("<leader>fp", telescope.find_files)
keymap("<leader>fd", function()
  telescope.buffers({ ignore_current_buffer = true, sort_mru = true, only_cwd = true }) -- sort all buffers by recency
end)
keymap("<leader>fc", telescope.command_history)
keymap("<leader>ft", telescope.resume)
keymap("<leader>fq", telescope.quickfixhistory)
-- some keymaps are defined in lsp.lua, to utilize on_attach
keymap("<leader>fe", function()
  telescope.diagnostics({ bufnr = 0 })
end)
keymap("<leader>fE", telescope.diagnostics)

keymap("<leader>r", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap("<leader>R", function()
  telescope.grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" })
end)
keymap("<leader>b", function()
  telescope.buffers({ ignore_current_buffer = true, sort_mru = true, only_cwd = false }) -- sort all buffers by recency
end)

keymap("<leader>p", function() require("zi.switch_repo").fd_projects(require("telescope.themes").get_ivy()) end)
keymap("<leader>P", "<Cmd>Telescope repo<CR>")

-- neoclip
keymap("<leader>y", "<Cmd>Telescope neoclip<CR>")

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
keymap("<leader>je", ":LspRestart<Cr>:sleep 1<Cr>:e<Cr>")                            -- TOOD: might be a better way
keymap("<leader>jj", function() vim.diagnostic.open_float({ focusable = true }) end) -- <C-w><C-w> (or just w) to focus on the float window
keymap("<leader>jn", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end)
keymap("<leader>jp", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end)
keymap("<leader>jr", telescope.lsp_references)


-- disable inlay hint by default and toggle
vim.lsp.inlay_hint.enable(false)
keymap("<leader>jh", function()
  local toggle = not vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(toggle)
end)

-- -- inlay hint only displayed in normal mode
-- local augroup_inlay_hint = augroup("zi_inlay_hint", {})
-- au({ "LspAttach", "InsertEnter", "InsertLeave" }, {
--   group = augroup_inlay_hint,
--   callback = function(args)
--     local enabled = args.event ~= "InsertEnter"
--     vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
--   end,
-- })

-- git, more keymaps defined in git
local function open_current_buffer_in_github()
  local handle = io.popen("git config --get remote.origin.url")
  local git_remote_url = handle:read("*a"):gsub('\n', '')
  handle:close()

  local github_base_url = git_remote_url:gsub("git@github.com:", "https://github.com/"):gsub("%.git", "")

  local handle = io.popen("git rev-parse --show-toplevel")
  local git_root = handle:read("*a"):gsub('\n', '')
  handle:close()

  -- Get the absolute path of the current file
  local file_path = vim.fn.expand("%:p")

  local relative_file_path = ""
  if git_root ~= "" and file_path:sub(1, #git_root) == git_root then
    -- Subtract the Git root from the file path to get the relative path
    -- Adding 2 because we want to remove the leading '/' as well
    relative_file_path = file_path:sub(#git_root + 2)
  end

  local handle = io.popen("git branch --show-current")
  local branch_name = handle:read("*a"):gsub('\n', '')
  handle:close()

  local github_file_url = string.format("%s/blob/%s/%s", github_base_url, branch_name, relative_file_path)

  -- Open URL in default browser. Adjust the command according to your OS.
  -- This example uses 'xdg-open' for Linux. Use 'open' for macOS, or 'start' for Windows.
  vim.fn.execute("!open " .. github_file_url)
end

keymap("<leader>gc", telescope.git_branches)
keymap("<leader>gl", open_current_buffer_in_github)


-- custom commands
vim.cmd([[:command! Ve e ~/.config/nvim/init.lua]])

-- hit '/' highlights then enter search mode
keymap("/", ":set hls<Cr>/")

-- need to disable `silent` for Cmd without Cr, otherwise the text will not show up  in cmdlin
keymap("<leader>ss", "<Cmd>set hls<Cr>:.,$s///gc" .. string.rep("<Left>", 4), "n", { silent = false })
keymap("<leader>sS", "<Cmd>set hls<Cr>:.,$S///gc" .. string.rep("<Left>", 4), "n", { silent = false })   -- Subvert from vim-abolish
keymap("<leader>sq", "<Cmd>set hls<Cr>:cdo %s///gc" .. string.rep("<Left>", 4), "n", { silent = false }) -- substitute in quickfix list

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
  if vim.opt.cmdheight:get() > 0 then
    vim.opt.cmdheight = 0
  else
    vim.opt.cmdheight = 1
  end
end
keymap("<leader>vc", toggle_cmdline)

keymap("<leader>vs", "<CMD>ScrollbarToggle<Cr>")

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
