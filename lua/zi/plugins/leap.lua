return {
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").opts.safe_labels = {}
      require("leap").opts.labels =
      { "f", "d", "s", "g", "j", "k", "l", "h", "r", "t", "v", "b", "y", "u", "n", "a" }
      require("leap").opts.case_sensitive = true

      require('leap.user').set_repeat_keys('<enter>', '<backspace>', {
        -- When true, repeat in the direction of the last motion
        -- (by default, <cr>/<bs> always goes forward/backward).
        relative_directions = false,
        modes = { 'n', 'x', 'o' },
      })

      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set('n', 'gs', '<Plug>(leap-from-window)')
    end,
  },
}
