-- single source of truth for LSP servers, consumed by both profiles:
-- mason-lspconfig's ensure_installed (advanced) and vim.lsp.enable (nvim-min)
return {
  "lua_ls",
  "rust_analyzer",
  "pyright",
  "gopls",
  "ts_ls",    -- js + ts
  "marksman", -- markdown
  "bashls",
  "jsonls",
  "helm_ls",
  "yamlls", -- would mess up helm without helm_ls setup
  "terraformls",
  "taplo",  -- toml
}
