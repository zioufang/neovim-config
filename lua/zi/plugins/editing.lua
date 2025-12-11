return {
  -- gc for comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      local ft = require('Comment.ft')
      ft.set('hcl', '# %s')
      require("Comment").setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ignore = '^$', -- ignore empty lines
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
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
}
