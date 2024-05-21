local wo = vim.wo
local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local p = require("utils/pattern")

-- toggle relative line number based on mode + focus
local augroup_number_toggle = augroup("zi_numbertoggle", {})
au({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = augroup_number_toggle,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

au({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = augroup_number_toggle,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd("redraw")
    end
  end,
})

-- highlight text on yank
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

-- auto set cwd based on project root pattern
function _G.AutoSetCwd()
  -- don't set cwd with the following filetype
  if vim.tbl_contains({ "telescope", "aerial", "qf", "NvimTree", "packer" }, vim.filetype) then
    return
  end
  local root, _ = p.find_pattern_root()
  if root == nil then
    return false
  end
  if vim.fn.getcwd() ~= root then
    vim.api.nvim_set_current_dir(root)
  end
  return true
end

vim.cmd([[
augroup zi_set_cwd
autocmd!
autocmd BufEnter * lua AutoSetCwd()
augroup END
]])

-- highlight number for cursorline
local augroup_cursorline = augroup("zi_cursorline", {})
au("WinEnter", {
  group = augroup_cursorline,
  callback = function()
    if vim.bo.filetype ~= "" then -- disable it for terminal
      wo.cursorline = true
    else
      wo.cursorline = false
    end
  end,
})
au("WinLeave", {
  group = augroup_cursorline,
  callback = function()
    wo.cursorline = false
  end,
})

-- Delayed highlight Cursorline autocmd
-- but terminal in a newtab would still display a cursorline
-- which is super annoying, disable it for now

-- wo.cursorlineopt = "both"
-- local timer = vim.loop.new_timer()
-- local timeout = 500
-- au({ "CursorMoved", "CursorMovedI" }, {
--  group = augroup_cursorline,
-- 	callback = function()
-- 		wo.cursorlineopt = "number"
-- 		timer:start(
-- 			timeout,
-- 			0,
-- 			vim.schedule_wrap(function()
-- 				wo.cursorlineopt = "both"
-- 			end)
-- 		)
-- 	end,
-- })

-- Change tab size to 4 for certain filetypes
local augroup_tab_ft = augroup("zi_tab_ft", {})
au({ "BufNewFile", "BufRead" }, {
  group = augroup_tab_ft,
  pattern = "*.rs,*.py,*.go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- folding by default in zinotes dir
-- showing only heading-2 and above
local augroup_folding_notes = augroup("zi_folding_notes", {})
au({ "BufNewFile", "BufRead" }, {
  group = augroup_folding_notes,
  pattern = "*/zinotes/**",
  callback = function()
    vim.opt_local.foldlevel = 2
  end,
})
