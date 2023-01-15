local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	-- lsp
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})

	-- auto completion
	use({ -- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua", -- cmpl src for neovim lua api
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			--  "rafamadriz/friendly-snippets" ,
		},
	})

	-- tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- gc for comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use("nvim-telescope/telescope-live-grep-args.nvim")
	use("FeiyouG/command_center.nvim") -- flat list of customized commands

	-- movement
	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").opts.safe_labels = {}
			require("leap").opts.labels =
				{ "f", "d", "s", "g", "j", "k", "l", "h", "r", "t", "v", "b", "y", "u", "n", "a" }
			require("leap").opts.case_sensitive = true
			require("leap").add_default_mappings()
		end,
	})

	-- better file explorer
	-- use({ "tamago324/lir.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use("stevearc/oil.nvim")
	-- backup explorer for whole project view
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				hijack_netrw = false, -- using oil
				respect_buf_cwd = true,
				sync_root_with_cwd = true,
				view = {
					mappings = {
						custom_only = false,
						list = {
							{ key = "gh", action = "toggle_dotfiles" },
							{ key = "p", action = "preview" },
						},
					},
				},
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				git = { enable = true },
				filters = { dotfiles = true },
				actions = {
					open_file = { window_picker = { enable = false } }, -- open file in the last window
				},
			})
			vim.keymap.set("n", "<leader>t", "<Cmd>NvimTreeToggle<Cr>", {})
		end,
	})
	-- aerial
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end,
	})

	-- auto formatter
	use("sbdchd/neoformat")

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- better clilpboard management
	use("AckslD/nvim-neoclip.lua")

	-- better quickfix
	use({
		"kevinhwang91/nvim-bqf",
		config = function()
			require("bqf").setup({ auto_resize_height = true })
		end,
	})
	use("gabrielpoca/replacer.nvim") -- edit directly in quickfix buffer

	-- surround
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	-- better substitution + case coercion
	use("tpope/vim-abolish")
	use({
		"markonm/traces.vim",
		config = function()
			vim.g.traces_abolish_integration = 1
		end,
	}) -- preview support for abolish

	-- running git in cmd mode
	use({
		"dinhhuy258/git.nvim",
		config = function()
			require("git").setup({
				default_mappings = false,
				keymaps = {
					-- <>gb for popup blame
					-- <>gB for full blame
					browse = "<leader>gl",
				},
			})
		end,
	})

	-- iv + av for subwords in snake/camel cases
	use("kana/vim-textobj-user")
	use("Julian/vim-textobj-variable-segment")

	-- tmux
	use({
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	})

	-- undotree
	use({
		"mbbill/undotree",
		config = function()
			vim.cmd([[
            let g:undotree_WindowLayout = 2
            let g:undotree_ShortIndicators = 1
            ]])
			vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<Cr>")
		end,
	})

	-----------------------
	-- Language Specific --
	-----------------------
	-- Rust
	use("simrat39/rust-tools.nvim") -- mostly for inlayHints

	-- neovim  dev
	use("folke/neodev.nvim")
	use("rafcamlet/nvim-luapad")
	use("nvim-lua/plenary.nvim")
	use("rcarriga/nvim-notify")

	-----------------------
	-- Window Management --
	-----------------------
	use({
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 5
			vim.o.winminwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				autowidth = {
					enable = false,
				},
			})
			vim.keymap.set("n", "<F11>", "<Cmd>WindowsMaximizeVertically<Cr>")
			vim.keymap.set("n", "<F10>", "<Cmd>WindowsMaximize<Cr>")
		end,
	})
	use({
		"declancm/maximize.nvim",
		config = function()
			require("maximize").setup({
				default_keymaps = false,
			})
			vim.keymap.set({ "n", "t" }, "<F12>", "<Cmd>lua require('maximize').toggle()<CR>")
		end,
	})
	-- use({
	-- 	"sindrets/winshift.nvim",
	-- 	config = function()
	-- 		require("winshift").setup({
	-- 			window_picker = function()
	-- 				return require("winshift.lib").pick_window({
	-- 					picker_chars = "SDFGHJKL1234567890",
	-- 				})
	-- 			end,
	-- 		})
	-- 		-- vim.keymap.set("n", "<C-W>M", "<Cmd>WinShift<Cr>")
	-- 		-- need to set cmdheight to non-zero, so the selection shows up. set it back to one afterwards (:set ch=0)
	-- 		vim.keymap.set("n", "<C-W>m", "<Cmd>set cmdheight=1<Cr><Cmd>WinShift swap<Cr>")
	-- 	end,
	-- }) -- swapping windows

	-----------------
	-- Eye Candies --
	-----------------
	use("stevearc/dressing.nvim") -- better default vim ui
	use("kyazdani42/nvim-web-devicons") -- pretty icons
	use({ "sainnhe/gruvbox-material" })
	use({ "sainnhe/sonokai" })
	use("folke/tokyonight.nvim") -- colorscheme, used by scrollbar.lua
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("petertriho/nvim-scrollbar")
	-- get lsp status out of status line
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})
	use({
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	})
	-- prettier qf
	use({
		"https://gitlab.com/yorickpeterse/nvim-pqf.git",
		config = function()
			require("pqf").setup()
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				vim.cmd([[let g:indent_blankline_enabled = v:false]]), -- disable by default for toggle
				vim.keymap.set("n", "<leader>vi", "<Cmd>IndentBlanklineToggle<Cr>"),
			})
		end,
	})
	-- hightlight word under cursor
	use({
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 300,
				providers = { "lsp", "treesitter" },
				filetype_denylist = { "oil", "telescope", "qf" },
				min_count_to_highlight = 2,
			})
			vim.keymap.set("n", "<leader>vw", "<Cmd>IlluminateToggle<Cr>")
		end,
	})
	use({
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)

if packer_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("lua/plugins.lua"),
})