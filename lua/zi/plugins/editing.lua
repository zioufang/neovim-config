return {
  -- gc for comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      local ft = require('Comment.ft')
      ft.set('hcl', '# %s')
      require("Comment").setup({
        ignore = '^$', -- ignore empty lines
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = true,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- better substitution + case coercion
  { "tpope/vim-abolish", event = "VeryLazy" },
  -- preview support for abolish
  {
    "markonm/traces.vim",
    event = "VeryLazy",
    config = function()
      vim.g.traces_abolish_integration = 1
    end,
  },

  -- doc generation
  {
    "danymat/neogen",
    event = "VeryLazy",
    keys = { { "<leader>d", "<Cmd>lua require('neogen').generate()<Cr>" } },
    config = true,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- iv + av for subwords in snake/camel cases
  -- {
  --   "kana/vim-textobj-user",
  --   event = "VeryLazy",
  --   dependencies = "Julian/vim-textobj-variable-segment",
  -- },

}
