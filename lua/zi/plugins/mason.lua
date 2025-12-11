return {
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
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
      automatic_enable = true
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  }

}
