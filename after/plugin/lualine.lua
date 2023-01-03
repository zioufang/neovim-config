local function maximize_status()
	return vim.t.maximized and " " or ""
end

local function lsp_provider()
	local clients = {}
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		if client.name == "pyright" then
			-- add (venv) if customized python path is detected
			if client.config.settings.python["pythonPath"] ~= nil then
				clients[#clients + 1] = client.name .. "(venv)"
			end
		else
			clients[#clients + 1] = client.name
		end
	end
	return table.concat(clients, " ")
end

require("lualine").setup({
	theme = "auto",
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"filename",
				-- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				path = 3,
				symbols = {
					unnamed = "[Home]", -- Text to show for unnamed buffers.
				},
			},
		}, -- full path
		lualine_c = { { "branch", padding = { left = 1, right = 0 } }, { "diff", separator = "|" } },
		lualine_x = {
			{ maximize_status, separator = "|" },
			{ "aerial", dense = true, separator = "|" },
			{ "diagnostics", separator = "|" },
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 0 },
			},
			{ lsp_provider, color = { fg = "Orange" } },
		},
		lualine_y = {},
		lualine_z = {},
	},
	-- inactive_sections = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = {
	-- 		{
	-- 			"filename",
	-- 			symbols = {
	-- 				unnamed = "[Home]",
	-- 			},
	-- 		},
	-- 	},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
})
