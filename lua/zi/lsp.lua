local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "⚠" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    text = sign.text,
    numhl = "",
  })
end

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  signs = { active = signs },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
  },
})

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
  capabilities = capabilities,
})


vim.lsp.config("pyright", {
  before_init = function(_, config)
    local Path = require("plenary.path")
    local venv = Path:new(config.root_dir, ".venv", "bin", "python")
    if venv:is_file() then
      config.settings = config.settings or {}
      config.settings.python = config.settings.python or {}
      config.settings.python.pythonPath = tostring(venv)
    end
  end,

})
vim.lsp.enable("pyright")

vim.lsp.config("helm_ls", {
  settings = {
    ["helm-ls"] = {
      valuesFiles = {
        mainValuesFile = "values.yaml",
        lintOverlayValuesFile = "values.lint.yaml",
        additionalValuesFilesGlobPattern = "values*.yaml",
      },
      yamlls = {
        enabled = false,
        path = "yaml-language-server",
      },
    },
  },

})

vim.lsp.config("rust_analyzer", {
  settings = {
    inlayHints = { locationLinks = false },
    procMacro = { enable = true },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
  },

  commands = {
    RustOpenDocs = {
      function()
        vim.lsp.buf_request(
          vim.api.nvim_get_current_buf(),
          "experimental/externalDocs",
          vim.lsp.util.make_position_params(),
          function(err, url)
            if err then error(tostring(err)) end
            vim.fn.execute("!open " .. url)
          end
        )
      end,
      description = "Open rust docs in browser",
    },
  },

})
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")

vim.lsp.enable("bashls")
vim.lsp.enable("jsonls")
vim.lsp.enable("taplo")
vim.lsp.enable("marksman")

vim.lsp.enable("helm_ls")
vim.lsp.enable("terraformls")
