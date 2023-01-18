local command_center = require("command_center")

command_center.add({
	{
		desc = "GHOpenPr",
		cmd = "<Cmd>GHOpenPR<Cr>",
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
		desc = "Glow Markdown",
		cmd = "<Cmd>lua GlowMarkdown()<Cr>",
	},
	{
		desc = "BufferCloseHidden",
		cmd = "<Cmd>BufferCloseHidden<Cr>",
	},
	{
		desc = "Nvim Reload Config",
		cmd = "<Cmd>lua ReloadConfig()<Cr>",
	},
}, command_center.mode.ADD)
