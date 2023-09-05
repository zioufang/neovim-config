return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      -- local commander = require("commander")

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          scroll_strategy = "limit", -- or cycle
          layout_config = { prompt_position = "top", height = 0.95, width = 0.95 },
          mappings = {
            i = {
              -- delete buffer, can multi select with Tab first
              ["<C-x>"] = require("telescope.actions").delete_buffer,
              ["<C-s>"] = require("telescope.actions").select_horizontal,
              ["<C-d>"] = require("telescope.actions").results_scrolling_down,
              ["<C-u>"] = require("telescope.actions").results_scrolling_up,
              ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
              ["<C-Down>"] = require("telescope.actions").cycle_history_next,
              ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
            },
            n = {
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
              ["<C-s>"] = require("telescope.actions").select_horizontal,
              ["<C-d>"] = require("telescope.actions").results_scrolling_down,
              ["<C-u>"] = require("telescope.actions").results_scrolling_up,
              ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
              ["<C-Down>"] = require("telescope.actions").cycle_history_next,
              ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
            },
          },
        },
        pickers = {
          git_files = {
            theme = "ivy",
            preview = { hide_on_startup = true },
          },
          find_files = {
            theme = "ivy",
            preview = { hide_on_startup = true },
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          buffers = {
            theme = "ivy",
            preview = { hide_on_startup = true },
          },
          oldfiles = {
            theme = "ivy",
            preview = { hide_on_startup = true },
          },
          command_history = {
            theme = "ivy",
            preview = { hide_on_startup = true },
          },
        },
        extensions = {
          -- fzf EXACT match syntax
          -- 'word	include word
          -- ^music	start with music
          -- .mp3$	end with .mp3
          -- !fire	do not include fire
          -- !^music	do not start with music
          -- !.mp3$	do not end with .mp3
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          live_grep_args = {
            auto_quoting = false, -- enable/disable auto-quoting
            mappings = {
              -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-l>"] = lga_actions.quote_prompt({ postfix = " -g " }),
              },
            },
          },
          -- commander = {
          --   components = {
          --     commander.component.DESC,
          --     -- command_center.component.KEYS,
          --     -- command_center.component.CMD,
          --     -- command_center.component.CATEGORY,
          --   },
          --   -- Spcify by what components the commands is sorted
          --   -- Order does not matter
          --   sort_by = {
          --     commander.component.DESC,
          --     -- command_center.component.KEYS,
          --     -- command_center.component.CMD,
          --     -- command_center.component.CATEGORY,
          --   },
          --   separator = " ",
          --   theme = require("telescope.themes").get_ivy,
          -- },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")
      -- require("telescope").load_extension("commander")
      -- open qf in vertical
      -- local telescope_actions = require("telescope.actions")
      --
      -- local function send_to_quickfix(promtbufnr)
      --    telescope_actions.smart_send_to_qflist(promtbufnr)
      --    vim.cmd([[botright copen]])
      -- end
      --
      -- telescope.setup({
      --   defaults = {
      --     mappings = {
      --       ["n"] = {
      --         ["<C-q>"] = send_to_quickfix,
      --       },
      --        ["i"] = {
      --          ["<C-q>"] = send_to_quickfix,
      --        },
      --      },
      --   },
      -- })
    end,
  },

  -- extensions
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  -- {
  --   "FeiyouG/commander.nvim",
  --   config = function()
  --     require("zi.plugins.commander.setup")
  --     require("zi.plugins.commander.custom_commands")
  --   end,
  -- }, -- flat list of customized commands
}
