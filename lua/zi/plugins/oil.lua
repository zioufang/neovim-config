-- better file explorer
return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["q"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["`"] = "actions.open_cwd",
        [";"] = "actions.open_cmdline_dir",
        -- ["@"] = "actions.cd",
        -- ["~"] = "actions.tcd",
        ["gh"] = "actions.toggle_hidden",
      },
    })
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    vim.keymap.set(
      "n",
      "_",
      [[<Cmd>silent! vert sb<Cr>:silent! execute 'e ' .. expand('%:p:h')<CR>]],
      { noremap = true }
    )
  end,
}
