return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- show name of the lsp server for current buf
    local function lsp_provider()
      local clients = {}
      local buf_clients = vim.lsp.buf_get_clients()
      local client_cnt = vim.tbl_count(buf_clients)
      for _, client in pairs(buf_clients) do
        if client.name == "pyright" then
          local cwd = vim.fn.getcwd()
          -- use python path for pyright
          local py_path = client.config.settings.python["pythonPath"]
          if py_path ~= nil then
            py_path = py_path:gsub(cwd .. "/", ""):gsub("/.venv/bin/python", "")
            clients[#clients + 1] = "pyright[" .. py_path .. "]"
          end
        else
          clients[#clients + 1] = client.name
        end
      end
      return table.concat(clients, " ")
    end

    -- -- check if current branch of cwd is behind and ahead in commits compared to remote upstream
    -- local gstatus = { ahead = 0, behind = 0 }
    -- local function update_gstatus()
    -- 	local Job = require("plenary.job")
    -- 	Job:new({
    -- 		command = "git",
    -- 		args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
    -- 		on_start = function()
    -- 			vim.pretty_print("gstatus kicked off")
    -- 		end,
    -- 		on_exit = function(job, _)
    -- 			local res = job:result()[1]
    -- 			if type(res) ~= "string" then
    -- 				gstatus = { ahead = 0, behind = 0 }
    -- 				return
    -- 			end
    -- 			local ok, behind, ahead = pcall(string.match, res, "(%d+)%s*(%d+)")
    -- 			if not ok then
    -- 				vim.pretty_print("not ok")
    -- 				ahead, behind = 0, 0
    -- 			end
    -- 			gstatus = { ahead = ahead, behind = behind }
    -- 			vim.pretty_print("behind: " .. behind, "ahead: " .. ahead)
    -- 		end,
    -- 	}):start()
    -- end

    -- -- gstatus scheduled update
    -- if _G.Gstatus_timer == nil then
    -- 	_G.Gstatus_timer = vim.loop.new_timer()
    -- else
    -- 	_G.Gstatus_timer:stop()
    -- end
    -- _G.Gstatus_timer:start(2 * 000, 0, vim.schedule_wrap(update_gstatus))

    -- show cwd with icon and HOME replaced with ~
    local function current_working_dir()
      local home = os.getenv("HOME") or ""
      local cwd = vim.fn.getcwd()
      cwd = cwd:gsub(home, "~")
      return cwd
    end

    -- extension for oil.nvim
    local function oil_path()
      local home = os.getenv("HOME") or ""
      local buf_name = vim.fn.expand("%")
      buf_name = buf_name:gsub("oil://", "")
      buf_name = buf_name:gsub(home, "~")
      return " " .. buf_name
    end

    local oil = {
      winbar = {
        lualine_c = { oil_path },
      },
      filetypes = { "oil" }
    }

    -- custome color theme
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
          winbar = { "packer", "NvimTree", "aerial", "qf", "" }, -- vanilla terminal has "" as filetype
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
        lualine_z = {
          -- {
          -- 	function()
          -- 		return " " .. os.date("%H:%M")
          -- 	end,
          -- },
        },
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
      -- extensions = { oil },
    })
  end,
}
