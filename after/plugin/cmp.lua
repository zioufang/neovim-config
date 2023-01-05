local cmp = require("cmp")
local luasnip = require("luasnip")

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--   פּ ﯟ    some other good icons
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

-- TODO: set up snippet
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,noinsert",
		keyword_length = 2,
	},
	mapping = cmp.mapping.preset.insert({
		-- i = insert, s = select, c = cmd
		["<C-d>"] = cmp.mapping.scroll_docs(6),
		["<C-u>"] = cmp.mapping.scroll_docs(-6),
		["<C-c>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				})
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-y>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ -- confirm without replacement
					select = true,
				})
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<Enter>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ -- confirm without replacement
					select = true,
				})
			else
				fallback()
			end
		end, { "c" }),
		["<S-Tab>"] = cmp.mapping.complete(),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(cmp_select)
			elseif luasnip.jumpable() then
				luasnip.jump()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(cmp_select)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s", "c" }),
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
		{ name = "luasnip", option = { show_autosnippets = false } },
		{ name = "path" },
	},
})

-- cmd completion
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "cmdline" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- search completion
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

-- loading snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-- insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
