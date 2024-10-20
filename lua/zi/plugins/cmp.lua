return {
  "hrsh7th/nvim-cmp",
  -- load cmp on InsertEnter
  -- event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua", -- cmpl src for neovim lua api
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    -- {
    --   "zbirenbaum/copilot-cmp",
    --   dependencies = "copilot.lua",
    --   opts = {},
    --   config = function(_, opts)
    --     local copilot_cmp = require("copilot_cmp")
    --     copilot_cmp.setup(opts)
    --     -- attach cmp source whenever copilot attaches
    --     -- fixes lazy-loading issues with the copilot cmp source
    --     -- LazyVim.lsp.on_attach(function(client)
    --     --   copilot_cmp._on_insert_enter({})
    --     -- end, "copilot")
    --   end,
    -- },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    --   פּ    some other good icons
    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "ﯟ",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    -- default selection behaviour is select only, and with Tab or C-j to confirm
    -- some lsp doesn't support insertReplaceEdit feature, e.g. gopls, thus default to replace
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,noinsert",
        keyword_length = 1,
      },
      mapping = cmp.mapping.preset.insert({
        -- i = insert, s = select, c = cmd
        ["<C-d>"] = cmp.mapping.scroll_docs(6),
        ["<C-u>"] = cmp.mapping.scroll_docs(-6),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Insert,
            })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping.complete(),
        ["<C-n>"] = cmp.mapping({
          s = function(fallback)
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            elseif luasnip.jumpable() then
              luasnip.jump()
            else
              fallback()
            end
          end,
          -- more intuitive to do select insert in cmdline
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
              fallback()
            end
          end,
        }),
        ["<C-p>"] = cmp.mapping({
          s = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          -- more intuitive to do select insert in cmdline
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
              fallback()
            end
          end,
        }),
      }),
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip",                option = { show_autosnippets = false } },
        { name = "path" },
      },
    })

    -- cmd completion
    cmp.setup.cmdline(":", {
      completion = {
        completeopt = "menu,menuone",
        keyword_length = 1,
      },
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" },
      }),
    })

    -- search completion
    cmp.setup.cmdline("/", {
      completion = {
        completeopt = "menu,menuone",
        keyword_length = 2,
      },
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- loading snippets
    require("luasnip").filetype_extend("typescriptreact", { "typescript" })
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
  end,
}
