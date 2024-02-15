return {
  -- neovim  dev
  { "rafcamlet/nvim-luapad", cmd = "Luapad" },
  { "nvim-lua/plenary.nvim" },
  { "rcarriga/nvim-notify" },

  -- running git in cmd mode
  -- used mostly for browse and blame
  {
    "dinhhuy258/git.nvim",
    keys = { { "<leader>gl" }, { "<leader>gb" } },
    opts = {
      default_mappings = false,
      keymaps = {
        blame = "<leader>gb",
        browse = "<leader>gl",
      },
    },
  },

  -- picking icons
  {
    "ziontee113/icon-picker.nvim",
    cmd = "IconPickerInsert",
    opts = {
      disable_legacy_commands = true,
    },
  },
  { "towolf/vim-helm" },
}
