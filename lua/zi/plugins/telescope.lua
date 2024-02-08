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
          repo = {
            list = {
              fd_opts = {
                "--max-depth",
                "3",
              },
              search_dirs = {
                "~/projects",
              },
              file_ignore_patterns = {
                "/%.cache/",
                "/%.cargo/",
                "/%.venv/",
                "/%.terraform/",
              },
            },
            settings = {
              auto_lcd = true,
            }
          },
        },
      })

      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("repo")
    end,
  },

  -- extensions
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { 'cljoly/telescope-repo.nvim' },
}
