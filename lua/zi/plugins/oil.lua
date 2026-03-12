-- better file explorer
return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      skip_confirm_for_simple_edits = true,
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["gh"] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
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
