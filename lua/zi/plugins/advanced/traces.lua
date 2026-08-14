-- preview support for abolish
return {
  {
    "markonm/traces.vim",
    event = "VeryLazy",
    config = function()
      vim.g.traces_abolish_integration = 1
    end,
  },
}
