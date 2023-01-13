local p = require("utils/pattern")

M = {}
function M.auto_set_cwd()
	-- don't set cwd with the following filetype
	if vim.tbl_contains({ "telescope", "aerial", "qf", "NvimTree", "packer", "oil" }, vim.filetype) then
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

return M
