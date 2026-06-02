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
        ["<C-r>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["gh"] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["yf"] = {
          callback = function()
            -- copy relative path
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()

            if not entry or not dir then
              return
            end

            local full_path = vim.fs.normalize(dir .. entry.name)
            local relative_path = vim.fn.fnamemodify(full_path, ":.")
            vim.fn.setreg("+", relative_path)
          end,

          mode = "n"
        },
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
