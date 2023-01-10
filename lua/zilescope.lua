local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

M = {}

local function enter_dir(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	if selected == nil then
		actions.close(prompt_bufnr)
		return
	end
	local dir = selected.value
	-- TODO: the very first dir entered doesn't change cwd for some reason
	vim.api.nvim_set_current_dir(dir)

	local cmd = "silent edit! " .. dir
	vim.cmd(cmd)
end

-- TODO: introduce recency, frequency etc.
function M.fd_projects()
	local cmd_fd_projects = {
		"fd",
		"--type",
		"d",
		"--hidden",
		"--max-depth",
		"3",
		".git$",
		vim.fn.expand("~/projects"),
	}
	local job_opts_fd_projects = {
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
			local display_path = table.concat(display, "/")

			return { value = path, ordinal = path, display = display_path }
		end,
	}

	local picker_opts_fd_projects = {
		finder = finders.new_oneshot_job(cmd_fd_projects, job_opts_fd_projects),
		sorter = sorters.get_generic_fuzzy_sorter(),
		attach_mappings = function(_, map)
			map("i", "<Cr>", enter_dir)
			return true
		end,
	}
	local picker_fd_proejcts = pickers.new(picker_opts_fd_projects)
	picker_fd_proejcts:find()
end

return M
