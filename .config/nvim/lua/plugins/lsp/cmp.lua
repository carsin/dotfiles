local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- don't intiialize cmp in telescope buffs
vim.cmd([[
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
]])

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- load friendlysnippets into LuaSnip
vim.cmd([[ lua require("luasnip/loaders/from_vscode").lazy_load() ]])

-- handle <CR> properly
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-p>'] = cmp.mapping.scroll_docs(-4),
    ['<C-n>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<esc>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
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
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    -- { name = 'luasnip', priority = 40  },
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'buffer', keyword_length = 5, max_item_count = 5 },
    { name = 'spell' },
    { name = 'tmux', options = { all_panes = false }},
    -- { name = 'cmp_tabnine', priority = 50 },
  },
	formatting = {
    format = require("lspkind").cmp_format({with_text = true, menu = ({
      buffer = "[Buffer]",
      nvim_lua = '[VimApi]',
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      tmux = "[Tmux]",
      path = "[Path]",
      spell = "[Spell]",
      calc = "[Calc]",
      latex_symbols = "[Latex]",
      -- cmp_tabnine = "[TabNine]",
    })}),
	},
  documentation = {
    border = nil,
  },
  experimental = {
    ghost_text = false,
  }
}

-- cmdline
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})


-- don't start cmp in file types
vim.cmd([[ autocmd FileType vimwiki lua require('cmp').setup.buffer { enabled = false } ]])
vim.cmd([[ autocmd FileType markdown lua require('cmp').setup.buffer { enabled = false } ]])
