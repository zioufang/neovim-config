-- hightlight word under cursor
return {
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
      vim.cmd([[hi IlluminatedWordText gui=reverse]])
      vim.cmd([[hi IlluminatedWordRead gui=reverse]])
      vim.cmd([[hi IlluminatedWordWrite gui=reverse]])
    end,
  },
}
