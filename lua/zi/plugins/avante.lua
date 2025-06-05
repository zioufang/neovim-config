return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,                                                                         -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  keys = { { "<leader>aR", "<Cmd>AvanteClear<CR>", desc = "Avante Clear Chat History" } }, -- or type /clear and submit in chat
  opts = {
    provider = "openai",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4.1-mini",
        timeout = 30 * 000,
        extra_request_body = {
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = "medium",  -- low|medium|high, only used for reasoning models
        },
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-latest",
        timeout = 30 * 000,
      },
    },
    behaviour = {
      use_cwd_as_project_root = true, -- this is required for getting file path right for sub directory
      auto_set_keymaps = true,
    },
    mappings = {
      diff = {
        ours = nil,
        theirs = nil,
        all_theirs = nil,
        both = nil,
        cursor = nil,
        next = "]a",
        prev = "[a",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      ask = "<leader>aA",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      focus = "<leader>aF",
      stop = "<leader>as",
      toggle = {
        default = "<leader>aa",
        debug = "<leader>ad",
        hint = "<leader>ah",
        suggestion = "<leader>aS",
        repomap = "<leader>am",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
        close_from_input = { normal = "q", insert = "<C-d>" }
      },
      files = {
        add_current = "<leader>af", -- Add current buffer to selected files
      },
      select_model = "<leader>a?",  -- Select model command
    },
  },


  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
