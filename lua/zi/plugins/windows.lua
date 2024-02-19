return {
  -- tmux
  {
    "numToStr/Navigator.nvim",
    config = true,
  },

  -- maximize with gaps
  {
    "anuvyklack/windows.nvim",
    keys = {
      { "<F12>", "<Cmd>WindowsMaximize<Cr>",           mode = { "n", "t" } },
      { "<F11>", "<Cmd>WindowsMaximizeVertically<Cr>", mode = { "n", "t" } },
    },
    dependencies = {
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
    end,
  },
}
