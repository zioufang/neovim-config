local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
	{
		desc = "PackerInstall",
		cmd = "<Cmd>PackerInstall<Cr>",
	},
	{
		desc = "PackerClean",
		cmd = "<Cmd>PackerClean<Cr>",
	},
	{
		desc = "RustSetInlayHints",
		cmd = "<Cmd>RustSetInlayHints<Cr>",
	},
	{
		desc = "RustUnsetInlayHints",
		cmd = "<Cmd>RustUnsetInlayHints<Cr>",
	},
	{
		desc = "RustExpandMacro",
		cmd = "<Cmd>RustExpandMacro<Cr>",
	},
	{
		desc = "IconPickerInsert",
		cmd = "<Cmd>IconPickerInsert<Cr>",
	},
	{
		desc = "Telescope spell_suggest",
		cmd = "<Cmd>Telescope spell_suggest<Cr>",
	},
	{
		desc = "Telescope search_history",
		cmd = "<Cmd>Telescope search_history<Cr>",
	},
	{
		desc = "Telescope quickfixhistory",
		cmd = "<Cmd>Telescope quickfixhistory<Cr>",
	},
	{
		desc = "Luapad (Scratch)",
		cmd = "<Cmd>Luapad<Cr>",
	},
	{
		desc = "Glow (Markdown Preview)",
		cmd = "<Cmd>Glow<Cr>",
	},
	{
		desc = "BufferCloseHidden",
		cmd = "<Cmd>BufferCloseHidden<Cr>",
	},
}, command_center.mode.ADD)

vim.cmd([[
command! -nargs=* BufferCloseHidden call BufferCloseHidden()
function! BufferCloseHidden()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bdelete! ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun
]])
