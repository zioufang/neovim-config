local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
	{
		desc = "PackerSync",
		cmd = "<Cmd>PackerSync<Cr>",
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
}, command_center.mode.ADD)