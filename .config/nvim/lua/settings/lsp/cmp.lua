local cmp = require("cmp")
local luasnip = require("luasnip")
local kind = cmp.lsp.CompletionItemKind

-- autopairs: If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- load friendlysnippets into LuaSnip
vim.cmd([[ lua require("luasnip/loaders/from_vscode").lazy_load() ]])

-- smart pairs compatibility
cmp.event:on("confirm_done", function(event)
	local item = event.entry:get_completion_item()
	local parensDisabled = item.data and item.data.funcParensDisabled or false
	if not parensDisabled and (item.kind == kind.Method or item.kind == kind.Function) then
		require("pairs.bracket").type_left("(")
	end
end)

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-p>"] = cmp.mapping.scroll_docs(-4),
		["<C-n>"] = cmp.mapping.scroll_docs(4),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		-- ["<CR>"] = cmp.mapping(function() -- smart pairs
    --   if not cmp.confirm({ select = false }) then
		-- 		require("pairs.enter").type()
		-- 	end
		-- end),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Esc>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "calc" },
		{ name = "buffer" },
		-- { name = "spell" },
		{ name = "tmux", options = { all_panes = false } },
		{ name = "crates" },
		{ name = "neorg" },
	},
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = true,
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			menu = {
				buffer = "[Buffer]",
				nvim_lua = "[VimApi]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				tmux = "[Tmux]",
				path = "[Path]",
				-- spell = "[Spell]",
				calc = "[Calc]",
				latex_symbols = "[Latex]",
				crates = "[Crates]",
				neorg = "[Org]",
			},
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	-- sorting = {
	--   comparators = {
	--     function(...) return cmp_buffer:compare_locality(...) end,
	--     -- The rest of your comparators...
	--   }
	-- },
	enabled = function()
		if vim.bo.ft == "TelescopePrompt" or vim.bo.ft == "frecency" then -- disable tscope
			return false
		elseif vim.bo.ft == "markdown" then
			local sources = cmp.get_config().sources
			for i = #sources, 1, -1 do
				local c = sources[i].name
				if c == "buffer" or c == "tmux" or c == "luasnip" then
					table.remove(sources, i)
				end
			end
			cmp.setup.buffer({ sources = sources })
			return true
		else
			-- disable completion in comments
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				local context = require("cmp.config.context")
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
			return true
		end
		return true
	end,
  window = {
    documentation = {
      border = nil,
    },
  },
	experimental = {
		ghost_text = true,
	},
})

-- cmdline
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
})
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- ignore stuff
vim.opt.wildignore = {
	"*.o",
	"*.obj,*~",
	"*.git*",
	"*.meteor*",
	"*vim/backups*",
	"*sass-cache*",
	"*mypy_cache*",
	"*__pycache__*",
	"*cache*",
	"*logs*",
	"*node_modules*",
	"**/node_modules/**",
	"*DS_Store*",
	"*.gem",
	"log/**",
	"tmp/**",
}
