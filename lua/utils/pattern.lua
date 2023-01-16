local uv = vim.loop

M = {}

-- can't make it M.globtopattern, because it would fail in find_pattern_root
local function globtopattern(g)
	-- Some useful references:
	-- - apr_fnmatch in Apache APR.  For example,
	--   http://apr.apache.org/docs/apr/1.3/group__apr__fnmatch.html
	--   which cites POSIX 1003.2-1992, section B.6.

	local p = "^" -- pattern being built
	local i = 0 -- index in g
	local c -- char at index i in g.

	-- unescape glob char
	local function unescape()
		if c == "\\" then
			i = i + 1
			c = g:sub(i, i)
			if c == "" then
				p = "[^]"
				return false
			end
		end
		return true
	end

	-- escape pattern char
	local function escape(c)
		return c:match("^%w$") and c or "%" .. c
	end

	-- Convert tokens at end of charset.
	local function charset_end()
		while 1 do
			if c == "" then
				p = "[^]"
				return false
			elseif c == "]" then
				p = p .. "]"
				break
			else
				if not unescape() then
					break
				end
				local c1 = c
				i = i + 1
				c = g:sub(i, i)
				if c == "" then
					p = "[^]"
					return false
				elseif c == "-" then
					i = i + 1
					c = g:sub(i, i)
					if c == "" then
						p = "[^]"
						return false
					elseif c == "]" then
						p = p .. escape(c1) .. "%-]"
						break
					else
						if not unescape() then
							break
						end
						p = p .. escape(c1) .. "-" .. escape(c)
					end
				elseif c == "]" then
					p = p .. escape(c1) .. "]"
					break
				else
					p = p .. escape(c1)
					i = i - 1 -- put back
				end
			end
			i = i + 1
			c = g:sub(i, i)
		end
		return true
	end

	-- Convert tokens in charset.
	local function charset()
		i = i + 1
		c = g:sub(i, i)
		if c == "" or c == "]" then
			p = "[^]"
			return false
		elseif c == "^" or c == "!" then
			i = i + 1
			c = g:sub(i, i)
			if c == "]" then
			-- ignored
			else
				p = p .. "[^"
				if not charset_end() then
					return false
				end
			end
		else
			p = p .. "["
			if not charset_end() then
				return false
			end
		end
		return true
	end

	-- Convert tokens.
	while 1 do
		i = i + 1
		c = g:sub(i, i)
		if c == "" then
			p = p .. "$"
			break
		elseif c == "?" then
			p = p .. "."
		elseif c == "*" then
			p = p .. ".*"
		elseif c == "[" then
			if not charset() then
				break
			end
		elseif c == "\\" then
			i = i + 1
			c = g:sub(i, i)
			if c == "" then
				p = p .. "\\$"
				break
			end
			p = p .. escape(c)
		else
			p = p .. escape(c)
		end
	end
	return p
end

-- returns project root, as well as method
-- copied from
-- https://github.com/ahmedkhalf/project.nvim/blob/685bc8e3890d2feb07ccf919522c97f7d33b94e4/lua/project_nvim/project.lua#L33
function M.find_pattern_root()
	local root_patterns = { ".git", "Makefile" }
	local search_dir = vim.fn.expand("%:p:h", true)
  -- remove prefix for oil.nvim buffers
  search_dir = search_dir:gsub("oil://", "")

	if vim.fn.has("win32") > 0 then
		search_dir = search_dir:gsub("\\", "/")
	end

	local last_dir_cache = ""
	local curr_dir_cache = {}

	local function get_parent(path)
		path = path:match("^(.*)/")
		if path == "" then
			path = "/"
		end
		return path
	end

	local function get_files(file_dir)
		last_dir_cache = file_dir
		curr_dir_cache = {}

		local dir = uv.fs_scandir(file_dir)
		if dir == nil then
			return
		end

		while true do
			local file = uv.fs_scandir_next(dir)
			if file == nil then
				return
			end

			table.insert(curr_dir_cache, file)
		end
	end

	local function is(dir, identifier)
		dir = dir:match(".*/(.*)")
		return dir == identifier
	end

	local function sub(dir, identifier)
		local path = get_parent(dir)
		while true do
			if is(path, identifier) then
				return true
			end
			local current = path
			path = get_parent(path)
			if current == path then
				return false
			end
		end
	end

	local function child(dir, identifier)
		local path = get_parent(dir)
		return is(path, identifier)
	end

	local function has(dir, identifier)
		if last_dir_cache ~= dir then
			get_files(dir)
		end
		-- can't use M.globtopattern
		local pattern = globtopattern(identifier)
		for _, file in ipairs(curr_dir_cache) do
			if file:match(pattern) ~= nil then
				return true
			end
		end
		return false
	end

	local function match(dir, pattern)
		local first_char = pattern:sub(1, 1)
		if first_char == "=" then
			return is(dir, pattern:sub(2))
		elseif first_char == "^" then
			return sub(dir, pattern:sub(2))
		elseif first_char == ">" then
			return child(dir, pattern:sub(2))
		else
			return has(dir, pattern)
		end
	end

	-- breadth-first search
	while true do
		for _, pattern in ipairs(root_patterns) do
			local exclude = false
			if pattern:sub(1, 1) == "!" then
				exclude = true
				pattern = pattern:sub(2)
			end
			if match(search_dir, pattern) then
				if exclude then
					break
				else
					return search_dir, "pattern " .. pattern
				end
			end
		end

		local parent = get_parent(search_dir)
		if parent == search_dir or parent == nil then
			return nil
		end

		search_dir = parent
	end
end

return M
