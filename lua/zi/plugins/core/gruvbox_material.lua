return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 9999,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1

      vim.cmd("colorscheme gruvbox-material")
    end,
  },
}
