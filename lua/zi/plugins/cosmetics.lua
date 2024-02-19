return {
  -- nicer default ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        insert_only = false,
      },
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<C-Up>"] = "HistoryPrev",
          ["<C-Down>"] = "HistoryNext",
        },
      },
    },
  },
  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      local colors = require("tokyonight.colors").setup()

      require("scrollbar").setup({
        show_in_active_only = false,
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = false, -- Requires gitsigns
          handle = true,
          search = false,   -- Requires hlslens
        },
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { text = { "-" }, priority = 1, color = colors.orange },
          Error = { text = { "=" }, priority = 2, color = colors.error },
          Warn = { text = { "=" }, priority = 3, color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  },

  -- get lsp status out of status line
  {
    "j-hui/fidget.nvim",
    config = true,
  },

  -- show indent line
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = { { "<leader>vi", "<Cmd>IBLToggle<CR>", desc = "Toggle Indent Line" } },
    config = {
      enabled = false
    },
  },

  -- hightlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        delay = 150,
        providers = { "lsp", "treesitter" },
        filetypes_denylist = { "oil", "telescope", "qf" },
        min_count_to_highlight = 2,
      })
      vim.keymap.set("n", "<leader>vw", "<Cmd>IlluminateToggle<Cr>")
      vim.cmd([[hi IlluminatedWordText gui=underline]])
      vim.cmd([[hi IlluminatedWordRead gui=underline]])
      vim.cmd([[hi IlluminatedWordWrite gui=underline]])
    end,
  },

  -- pretty fold
  {
    "anuvyklack/pretty-fold.nvim",
    config = true,
  },

  -- TODO: check out minimap
  -- mouse click movement: https://github.com/gorbit99/codewindow.nvim/issues/37
}
