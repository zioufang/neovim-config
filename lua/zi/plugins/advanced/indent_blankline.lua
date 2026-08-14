-- show indent line
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = { { "<leader>vi", "<Cmd>IBLToggle<CR>", desc = "Toggle Indent Line" } },
    config = {
      enabled = false
    },
  },
}
