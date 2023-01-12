-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/zioufang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/zioufang/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/zioufang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/zioufang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/zioufang/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["Navigator.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/Navigator.nvim",
    url = "https://github.com/numToStr/Navigator.nvim"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n‚\1\0\0\5\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\1K\0\1\0\27<cmd>AerialToggle!<CR>\14<leader>a\6n\bset\vkeymap\bvim\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["animation.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/animation.nvim",
    url = "https://github.com/anuvyklack/animation.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["command_center.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/command_center.nvim",
    url = "https://github.com/FeiyouG/command_center.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["git.nvim"] = {
    config = { "\27LJ\2\no\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\1\vbrowse\15<leader>gl\1\0\1\21default_mappings\2\nsetup\bgit\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/git.nvim",
    url = "https://github.com/dinhhuy258/git.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    config = { "\27LJ\2\nh\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16width_ratio\4Í™³æ\fÌ™³ÿ\3\17height_ratio\4Í™³æ\fÌ™³ÿ\3\nsetup\tglow\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["icon-picker.nvim"] = {
    config = { "\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\28disable_legacy_commands\2\nsetup\16icon-picker\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/icon-picker.nvim",
    url = "https://github.com/ziontee113/icon-picker.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nä\1\0\0\b\0\v\1\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\3\0006\3\3\0009\3\4\3'\5\5\0B\3\2\2>\3\1\0026\3\3\0009\3\6\0039\3\a\3'\5\b\0'\6\t\0'\a\n\0B\3\4\0?\3\0\0B\0\2\1K\0\1\0#<Cmd>IndentBlanklineToggle<Cr>\15<leader>vi\6n\bset\vkeymap-let g:indent_blankline_enabled = v:false\bcmd\bvim\nsetup\21indent_blankline\frequire\5€€À™\4\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lazygit.nvim"] = {
    config = { "\27LJ\2\n¤\2\0\0\5\0\b\0\f6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\1K\0\1\0\21<Cmd>LazyGit<Cr>\15<leader>gg\6n\bset\vkeymap¿\1            let g:lazygit_floating_window_winblend = 1\n            let g:lazygit_floating_window_scaling_factor = 1\n            let g:lazygit_floating_window_use_plenary = 1\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\nÔ\1\0\0\3\0\b\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0=\1\3\0006\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\5\0=\1\4\0006\0\0\0'\2\1\0B\0\2\0029\0\2\0+\1\2\0=\1\6\0006\0\0\0'\2\1\0B\0\2\0029\0\a\0B\0\1\1K\0\1\0\25add_default_mappings\19case_sensitive\1\17\0\0\6f\6d\6s\6g\6j\6k\6l\6h\6r\6t\6v\6b\6y\6u\6n\6a\vlabels\16safe_labels\topts\tleap\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["maximize.nvim"] = {
    config = { "\27LJ\2\n±\1\0\0\5\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0005\2\a\0'\3\b\0'\4\t\0B\0\4\1K\0\1\0.<Cmd>lua require('maximize').toggle()<CR>\n<F12>\1\3\0\0\6n\6t\bset\vkeymap\bvim\1\0\1\20default_keymaps\1\nsetup\rmaximize\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/maximize.nvim",
    url = "https://github.com/declancm/maximize.nvim"
  },
  middleclass = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/middleclass",
    url = "https://github.com/anuvyklack/middleclass"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neogit = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23auto_resize_height\2\nsetup\bbqf\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-neoclip.lua"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-pqf.git"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bpqf\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-scrollbar"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nü\3\0\0\a\0\29\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\b\0005\4\4\0004\5\3\0005\6\5\0>\6\1\0055\6\6\0>\6\2\5=\5\a\4=\4\t\3=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\20\0005\4\18\0005\5\17\0=\5\19\4=\4\21\3=\3\22\2B\0\2\0016\0\23\0009\0\24\0009\0\25\0'\2\26\0'\3\27\0'\4\28\0004\5\0\0B\0\5\1K\0\1\0\28<Cmd>NvimTreeToggle<Cr>\14<leader>t\6n\bset\vkeymap\bvim\factions\14open_file\1\0\0\18window_picker\1\0\0\1\0\1\venable\1\ffilters\1\0\1\rdotfiles\2\bgit\1\0\1\venable\2\24update_focused_file\1\0\2\venable\2\16update_root\2\tview\rmappings\1\0\0\tlist\1\0\2\vaction\fpreview\bkey\6p\1\0\2\vaction\20toggle_dotfiles\bkey\agh\1\0\1\16custom_only\1\1\0\3\23sync_root_with_cwd\2\20respect_buf_cwd\2\17hijack_netrw\1\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["oil.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["pretty-fold.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16pretty-fold\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["replacer.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/replacer.nvim",
    url = "https://github.com/gabrielpoca/replacer.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  sonokai = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/sonokai",
    url = "https://github.com/sainnhe/sonokai"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["traces.vim"] = {
    config = { "\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\31traces_abolish_integration\6g\bvim\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/traces.vim",
    url = "https://github.com/markonm/traces.vim"
  },
  undotree = {
    config = { "\27LJ\2\nÖ\1\0\0\5\0\b\0\f6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\1K\0\1\0\28<Cmd>UndotreeToggle<Cr>\14<leader>u\6n\bset\vkeymapl            let g:undotree_WindowLayout = 2\n            let g:undotree_ShortIndicators = 1\n            \bcmd\bvim\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n‹\2\0\0\5\0\14\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0\30<Cmd>IlluminateToggle<Cr>\15<leader>vw\6n\bset\vkeymap\bvim\22filetype_denylist\1\4\0\0\boil\14telescope\aqf\14providers\1\3\0\0\blsp\15treesitter\1\0\2\ndelay\3¬\2\27min_count_to_highlight\3\2\14configure\15illuminate\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment",
    url = "https://github.com/Julian/vim-textobj-variable-segment"
  },
  ["windows.nvim"] = {
    config = { "\27LJ\2\n½\2\0\0\5\0\18\0#6\0\0\0009\0\1\0)\1\5\0=\1\2\0006\0\0\0009\0\1\0)\1\5\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\t\0005\3\b\0=\3\n\2B\0\2\0016\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0B\0\4\0016\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\16\0'\4\17\0B\0\4\1K\0\1\0\29<Cmd>WindowsMaximize<Cr>\n<F10>'<Cmd>WindowsMaximizeVertically<Cr>\n<F11>\6n\bset\vkeymap\14autowidth\1\0\0\1\0\1\venable\1\nsetup\fwindows\frequire\16equalalways\16winminwidth\rwinwidth\6o\bvim\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/windows.nvim",
    url = "https://github.com/anuvyklack/windows.nvim"
  },
  ["winshift.nvim"] = {
    config = { "\27LJ\2\nc\0\0\3\0\4\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0D\0\2\0\1\0\1\17picker_chars\23SDFGHJKL1234567890\16pick_window\17winshift.lib\frequire·\1\1\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0003<Cmd>set cmdheight=1<Cr><Cmd>WinShift swap<Cr>\v<C-W>m\6n\bset\vkeymap\bvim\18window_picker\1\0\0\0\nsetup\rwinshift\frequire\0" },
    loaded = true,
    path = "/Users/zioufang/.local/share/nvim/site/pack/packer/start/winshift.nvim",
    url = "https://github.com/sindrets/winshift.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\nÖ\1\0\0\5\0\b\0\f6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\1K\0\1\0\28<Cmd>UndotreeToggle<Cr>\14<leader>u\6n\bset\vkeymapl            let g:undotree_WindowLayout = 2\n            let g:undotree_ShortIndicators = 1\n            \bcmd\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: maximize.nvim
time([[Config for maximize.nvim]], true)
try_loadstring("\27LJ\2\n±\1\0\0\5\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0005\2\a\0'\3\b\0'\4\t\0B\0\4\1K\0\1\0.<Cmd>lua require('maximize').toggle()<CR>\n<F12>\1\3\0\0\6n\6t\bset\vkeymap\bvim\1\0\1\20default_keymaps\1\nsetup\rmaximize\frequire\0", "config", "maximize.nvim")
time([[Config for maximize.nvim]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16pretty-fold\frequire\0", "config", "pretty-fold.nvim")
time([[Config for pretty-fold.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: icon-picker.nvim
time([[Config for icon-picker.nvim]], true)
try_loadstring("\27LJ\2\nY\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\28disable_legacy_commands\2\nsetup\16icon-picker\frequire\0", "config", "icon-picker.nvim")
time([[Config for icon-picker.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nä\1\0\0\b\0\v\1\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\3\0006\3\3\0009\3\4\3'\5\5\0B\3\2\2>\3\1\0026\3\3\0009\3\6\0039\3\a\3'\5\b\0'\6\t\0'\a\n\0B\3\4\0?\3\0\0B\0\2\1K\0\1\0#<Cmd>IndentBlanklineToggle<Cr>\15<leader>vi\6n\bset\vkeymap-let g:indent_blankline_enabled = v:false\bcmd\bvim\nsetup\21indent_blankline\frequire\5€€À™\4\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nü\3\0\0\a\0\29\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\b\0005\4\4\0004\5\3\0005\6\5\0>\6\1\0055\6\6\0>\6\2\5=\5\a\4=\4\t\3=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\20\0005\4\18\0005\5\17\0=\5\19\4=\4\21\3=\3\22\2B\0\2\0016\0\23\0009\0\24\0009\0\25\0'\2\26\0'\3\27\0'\4\28\0004\5\0\0B\0\5\1K\0\1\0\28<Cmd>NvimTreeToggle<Cr>\14<leader>t\6n\bset\vkeymap\bvim\factions\14open_file\1\0\0\18window_picker\1\0\0\1\0\1\venable\1\ffilters\1\0\1\rdotfiles\2\bgit\1\0\1\venable\2\24update_focused_file\1\0\2\venable\2\16update_root\2\tview\rmappings\1\0\0\tlist\1\0\2\vaction\fpreview\bkey\6p\1\0\2\vaction\20toggle_dotfiles\bkey\agh\1\0\1\16custom_only\1\1\0\3\23sync_root_with_cwd\2\20respect_buf_cwd\2\17hijack_netrw\1\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: glow.nvim
time([[Config for glow.nvim]], true)
try_loadstring("\27LJ\2\nh\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16width_ratio\4Í™³æ\fÌ™³ÿ\3\17height_ratio\4Í™³æ\fÌ™³ÿ\3\nsetup\tglow\frequire\0", "config", "glow.nvim")
time([[Config for glow.nvim]], false)
-- Config for: lazygit.nvim
time([[Config for lazygit.nvim]], true)
try_loadstring("\27LJ\2\n¤\2\0\0\5\0\b\0\f6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0B\0\4\1K\0\1\0\21<Cmd>LazyGit<Cr>\15<leader>gg\6n\bset\vkeymap¿\1            let g:lazygit_floating_window_winblend = 1\n            let g:lazygit_floating_window_scaling_factor = 1\n            let g:lazygit_floating_window_use_plenary = 1\n            \bcmd\bvim\0", "config", "lazygit.nvim")
time([[Config for lazygit.nvim]], false)
-- Config for: nvim-bqf
time([[Config for nvim-bqf]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23auto_resize_height\2\nsetup\bbqf\frequire\0", "config", "nvim-bqf")
time([[Config for nvim-bqf]], false)
-- Config for: nvim-pqf.git
time([[Config for nvim-pqf.git]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bpqf\frequire\0", "config", "nvim-pqf.git")
time([[Config for nvim-pqf.git]], false)
-- Config for: windows.nvim
time([[Config for windows.nvim]], true)
try_loadstring("\27LJ\2\n½\2\0\0\5\0\18\0#6\0\0\0009\0\1\0)\1\5\0=\1\2\0006\0\0\0009\0\1\0)\1\5\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\t\0005\3\b\0=\3\n\2B\0\2\0016\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\14\0'\4\15\0B\0\4\0016\0\0\0009\0\v\0009\0\f\0'\2\r\0'\3\16\0'\4\17\0B\0\4\1K\0\1\0\29<Cmd>WindowsMaximize<Cr>\n<F10>'<Cmd>WindowsMaximizeVertically<Cr>\n<F11>\6n\bset\vkeymap\14autowidth\1\0\0\1\0\1\venable\1\nsetup\fwindows\frequire\16equalalways\16winminwidth\rwinwidth\6o\bvim\0", "config", "windows.nvim")
time([[Config for windows.nvim]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
try_loadstring("\27LJ\2\nÔ\1\0\0\3\0\b\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0=\1\3\0006\0\0\0'\2\1\0B\0\2\0029\0\2\0005\1\5\0=\1\4\0006\0\0\0'\2\1\0B\0\2\0029\0\2\0+\1\2\0=\1\6\0006\0\0\0'\2\1\0B\0\2\0029\0\a\0B\0\1\1K\0\1\0\25add_default_mappings\19case_sensitive\1\17\0\0\6f\6d\6s\6g\6j\6k\6l\6h\6r\6t\6v\6b\6y\6u\6n\6a\vlabels\16safe_labels\topts\tleap\frequire\0", "config", "leap.nvim")
time([[Config for leap.nvim]], false)
-- Config for: winshift.nvim
time([[Config for winshift.nvim]], true)
try_loadstring("\27LJ\2\nc\0\0\3\0\4\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0D\0\2\0\1\0\1\17picker_chars\23SDFGHJKL1234567890\16pick_window\17winshift.lib\frequire·\1\1\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0B\0\4\1K\0\1\0003<Cmd>set cmdheight=1<Cr><Cmd>WinShift swap<Cr>\v<C-W>m\6n\bset\vkeymap\bvim\18window_picker\1\0\0\0\nsetup\rwinshift\frequire\0", "config", "winshift.nvim")
time([[Config for winshift.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n‚\1\0\0\5\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0B\0\4\1K\0\1\0\27<cmd>AerialToggle!<CR>\14<leader>a\6n\bset\vkeymap\bvim\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: traces.vim
time([[Config for traces.vim]], true)
try_loadstring("\27LJ\2\n<\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\31traces_abolish_integration\6g\bvim\0", "config", "traces.vim")
time([[Config for traces.vim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n‹\2\0\0\5\0\14\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\0016\0\b\0009\0\t\0009\0\n\0'\2\v\0'\3\f\0'\4\r\0B\0\4\1K\0\1\0\30<Cmd>IlluminateToggle<Cr>\15<leader>vw\6n\bset\vkeymap\bvim\22filetype_denylist\1\4\0\0\boil\14telescope\aqf\14providers\1\3\0\0\blsp\15treesitter\1\0\2\ndelay\3¬\2\27min_count_to_highlight\3\2\14configure\15illuminate\frequire\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: git.nvim
time([[Config for git.nvim]], true)
try_loadstring("\27LJ\2\no\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\1\vbrowse\15<leader>gl\1\0\1\21default_mappings\2\nsetup\bgit\frequire\0", "config", "git.nvim")
time([[Config for git.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
