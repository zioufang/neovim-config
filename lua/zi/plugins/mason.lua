return {
  {
    'neovim/nvim-lspconfig'
  },
  { 'mason-org/mason.nvim', opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    -- lazy = false,
    -- NOTE: new lsp needs to be enabled in lsp.lua
    opts = {
      ensure_installed = {
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

      },
    },
  }
}
