return {
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
