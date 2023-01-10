local function maximize_status()
	return vim.t.maximized and " " or ""
end

local function winbar_icon()
	return ""
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

-- assuming two parent dirs before cwd,
-- /Usrs/username/(cwd)
local function current_working_dir()
	local path = vim.split(vim.fn.getcwd(), "/")
	local cwd = { unpack(path, 4, #path) }
	local display = table.concat(cwd, "/")
	return "ﮟ ~/" .. display
end

local custom_auto = require("lualine.themes.auto")
local b_white = "#cccccc"
local c_white = "#aaaaaa"

custom_auto.normal["b"]["fg"] = b_white
custom_auto.insert["b"]["fg"] = b_white
custom_auto.visual["b"]["fg"] = b_white
custom_auto.terminal["b"]["fg"] = b_white
custom_auto.replace["b"]["fg"] = b_white

custom_auto.normal["c"]["fg"] = c_white
custom_auto.insert["c"]["fg"] = c_white
custom_auto.visual["c"]["fg"] = c_white
custom_auto.terminal["c"]["fg"] = c_white
custom_auto.replace["c"]["fg"] = c_white

require("lualine").setup({
	options = {
		theme = custom_auto,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = { "packer", "NvimTree", "aerial", "qf", "" }, -- "" filetype is terminal
		},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				current_working_dir,
			},
		},
		lualine_c = {
			{
				"branch",
				padding = { left = 1, right = 0 },
			},
			{ "diff", separator = "|" },
		},
		lualine_x = {
			{ maximize_status, separator = "|" },
			{
				"aerial",
				dense = true,
				separator = "|",
				color = { fg = "#f28534" },
			},
			{ "diagnostics", separator = "|" },
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 1 },
			},
			{ lsp_provider },
		},
		lualine_y = {},
		lualine_z = { "os.date('%H:%M')" }, -- strftime() format string
	},
	-- TODO make oil buffer pretty in winbar
	winbar = {
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				path = 1,
				color = { fg = "White" },
				symbols = {
					modified = "[+]",
					readonly = "",
					unnamed = "[Home]",
				},
			},
		},
	},
	inactive_winbar = {
		lualine_c = {
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				path = 1,
				symbols = {
					modified = "[+]",
					readonly = "",
					unnamed = "[Home]",
				},
			},
		},
	},
})
