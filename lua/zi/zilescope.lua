local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
-- local actions_state = require("telescope.actions.state")
-- local entry_display = require("telescope.pickers.entry_display")

M = {}

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
				map("i", "<Cr>", actions.file_edit)
				map("i", "<C-v>", actions.file_vsplit)
				map("i", "<C-s>", actions.file_split)
				return true
			end,
		})
		:find()
end

return M
