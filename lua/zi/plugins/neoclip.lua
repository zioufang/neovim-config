return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
  },
  config = function()
    require('neoclip').setup({
      history = 1000,
      default_register = { '*', '+' },
      enable_persistent_history = true,
      keys = {
        telescope = {
          i = {
            select = {},
            paste = '<cr>',
            paste_behind = '<c-k>',
            replay = {},      -- replay a macro
            delete = '<c-x>', -- delete an entry
            edit = '<c-e>',   -- edit an entry
            custom = {},
          },
          n = {
            select = '<cr>',
            paste = 'p',
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = 'P',
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {},
          },
        },
      },
    }
    )
  end,
}
