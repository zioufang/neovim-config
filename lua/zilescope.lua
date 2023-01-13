local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

M = {}

-- action can be `edit`, `vsplit`, `split`
local function enter_dir(prompt_bufnr, act)
	local selected = actions_state.get_selected_entry()
	if selected == nil then
		actions.close(prompt_bufnr)
		return
	end
	local dir = selected.value
	-- TODO: the very first dir entered doesn't change cwd for some reason
	vim.api.nvim_set_current_dir(dir)

	local cmd = "silent " .. act .. " " .. dir
	vim.cmd(cmd)
end

local function enter_dir_edit(prompt_bufnr)
	enter_dir(prompt_bufnr, "edit!")
end

local function enter_dir_vsplit(prompt_bufnr)
	enter_dir(prompt_bufnr, "vsplit")
end

local function enter_dir_split(prompt_bufnr)
	enter_dir(prompt_bufnr, "split")
end

-- TODO: introduce recency, frequency etc.
function M.fd_projects(theme)
	local opts = theme or {}

	local cmd = {
		"fd",
		"--type",
		"d",
		"--hidden",
		"--max-depth",
		"3",
		"--glob",
		"**/.git",
		-- add search directories for projects
		vim.fn.expand("~/projects"),
		vim.fn.expand("~/.config/nvim"),
	}

	local job_opts = {
		entry_maker = function(dir_path)
			local full = vim.split(dir_path, "/")
			local wanted = {}
			local display = {}

			-- (wanted)/.git
			for i = 1, #full - 2 do
				wanted[#wanted + 1] = full[i]
			end

			-- /Users/username/projects/(display_path)/.git
			for i = 5, #full - 2 do
				display[#display + 1] = full[i]
			end

			local path = table.concat(wanted, "/")
			local project_name = table.concat(display, "/")
			return { value = path, ordinal = path, display = project_name }
		end,
	}

	pickers
		.new(opts, {
			prompt_title = "Projects",
			finder = finders.new_oneshot_job(cmd, job_opts),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(_, map)
				map("i", "<Cr>", enter_dir_edit)
				map("i", "<C-v>", enter_dir_vsplit)
				map("i", "<C-s>", enter_dir_split)
				return true
			end,
		})
		:find()
end

return M
