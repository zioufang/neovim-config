return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { "python", "rust", "lua", "javascript", "typescript", "go", "bash", "dockerfile", "yaml", "json", "toml", "sql" },
        callback = function() vim.treesitter.start() end,
      })

      require('nvim-treesitter').install { "python", "rust", "lua", "javascript", "typescript", "go", "bash", "dockerfile", "yaml", "json", "toml", "sql" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = "nvim-treesitter",
  },
}
