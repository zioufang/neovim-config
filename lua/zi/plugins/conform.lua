return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- ruff remove unused import, which can be annoying at the time
      -- python = { "ruff" },
      go = { "goimports", "gofmt" },
      markdown = { "prettierd" },
      sh = { "shfmt" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },

  },
}
