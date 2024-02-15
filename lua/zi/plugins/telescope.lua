return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          scroll_strategy = "limit", -- or cycle
          layout_config = { prompt_position = "top", height = 0.95, width = 0.95 },
          mappings = {
            i = {
              -- delete buffer, can multi select with Tab first
              ["<C-x>"] = actions.delete_buffer,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-d>"] = actions.results_scrolling_down,
              ["<C-u>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
            },
            n = {
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-d>"] = actions.results_scrolling_down,
              ["<C-u>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
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
          git_branches = {
            theme = "ivy",
            mappings = {
              i = {
                ["<CR>"] = actions.git_switch_branch
              }
            }

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
          ["zf-native"] = {
            -- options for sorting file-like items
            file = {
              -- override default telescope file sorter
              enable = true,

              -- highlight matching text in results
              highlight_results = true,

              -- enable zf filename match priority
              match_filename = true,

              -- optional function to define a sort order when the query is empty
              initial_sort = nil,
            },

            -- options for sorting all other items
            generic = {
              -- override default telescope generic item sorter
              enable = true,

              -- highlight matching text in results
              highlight_results = true,

              -- disable zf filename match priority
              match_filename = false,

              -- optional function to define a sort order when the query is empty
              initial_sort = nil,
            },
          },
        },
      })

      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("repo")
      require("telescope").load_extension("zf-native")
      require("telescope").load_extension("terraform_doc")
    end,
  },

  -- extensions
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { 'cljoly/telescope-repo.nvim' },
  { 'natecraddock/telescope-zf-native.nvim' },
  { 'ANGkeith/telescope-terraform-doc.nvim' }
}
