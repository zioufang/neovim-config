return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      go = { "goimports", "gofmt" },
      markdown = { "prettierd" },
      sh = { "shfmt" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },

  },
}
