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

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "j-hui/fidget.nvim" }, --lsp progress, for rust-analyzer
			{ "folke/neodev.nvim" },
		},
	})

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
	use("nvim-telescope/telescope-project.nvim")

	-- movement
	use("ggandor/leap.nvim")

	-- better file explorer
	use({ "tamago324/lir.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- auto formatter
	use("sbdchd/neoformat")

	-- terminal
	use("akinsho/toggleterm.nvim")

	-- used for auto change working directory
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({ patterns = { ".git" }, detection_methods = { "pattern", "lsp" } })
		end,
	})

	-- better substitution + case coercion
	use("tpope/vim-abolish")
	use("markonm/traces.vim") -- preview support for abolish

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	-- Language Specific

	-- Eye Candy
	use("kyazdani42/nvim-web-devicons")
	use("sainnhe/gruvbox-material")
	use("folke/tokyonight.nvim")
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("petertriho/nvim-scrollbar") -- also shows git (with gitsigns) & search (with hlslens)
	use("kevinhwang91/nvim-hlslens")
	use({
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
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
