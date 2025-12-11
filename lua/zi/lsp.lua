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

-- NOTE: mason.nvim auto enable
-- vim.lsp.enable({
--   "pyright",
--   "rust_analyzer",
--   "ts_ls",
--   "gopls",
--   "lua_ls",
--   "bashls",
--   "jsonls",
--   "taplo",
--   "marksman",
--   "helm_ls",
--   "terraformls",
-- })



vim.api.nvim_create_user_command("LspRestart", function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop(true)
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  if not timer then
    return vim.notify("Servers are stopped but havent been restarted")
  end
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start(client[1].config, { attach = false })
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ": restarted")
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = "Restart all the language client(s) attached to the current buffer",
})
