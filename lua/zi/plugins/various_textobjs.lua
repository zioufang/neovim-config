return {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
  config = function()
    -- https://github.com/chrisgrieser/nvim-various-textobjs?tab=readme-ov-file#list-of-text-objects
    require("various-textobjs").setup({ useDefaultKeymaps = true })
    -- subword
    vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
    vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
  end
}
