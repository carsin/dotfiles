local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp_buffer = require('cmp_buffer')

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
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'buffer' },
    { name = 'spell' },
    { name = 'tmux', options = { all_panes = false }},
    { name = 'crates' },
    { name = 'neorg' },
  },
	formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = ({
        buffer = "[Buffer]",
        nvim_lua = '[VimApi]',
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        tmux = "[Tmux]",
        path = "[Path]",
        spell = "[Spell]",
        calc = "[Calc]",
        latex_symbols = "[Latex]",
        crates = "[Crates]",
        neorg = "[Org]",
      })
    }),
	},
  -- sorting = {
  --   comparators = {
  --     function(...) return cmp_buffer:compare_locality(...) end,
  --     -- The rest of your comparators...
  --   }
  -- },
  enabled = function()
        if vim.bo.ft == "TelescopePrompt" then
            return false
        end
        if vim.bo.ft == "markdown" then
          local sources = cmp.get_config().sources
          for i = #sources, 1, -1 do
            local c = sources[i].name
            if c == 'buffer' or c == 'tmux' or c == 'luasnip' or c == 'path' then
              table.remove(sources, i)
            end
          end
          cmp.setup.buffer({ sources = sources })
          return true
        end
        local lnum, col =
            vim.fn.line("."), math.min(vim.fn.col("."), #vim.fn.getline("."))
        for _, syn_id in ipairs(vim.fn.synstack(lnum, col)) do
            syn_id = vim.fn.synIDtrans(syn_id) -- Resolve :highlight links
            if vim.fn.synIDattr(syn_id, "name") == "Comment" then
                return false
            end
        end
        if vim.tbl_contains(require('settings.treesitter').get_hl(), "TSComment") then
            return false
        end
        if string.find(vim.api.nvim_buf_get_name(0), "s_popup:/") then
            return false
        end
        return true
    end,
  documentation = {
    border = nil,
  },
  experimental = {
    ghost_text = true,
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

-- ignore stuff
vim.opt.wildignore = {
  '*.o',
  '*.obj,*~',
  '*.git*',
  '*.meteor*',
  '*vim/backups*',
  '*sass-cache*',
  '*mypy_cache*',
  '*__pycache__*',
  '*cache*',
  '*logs*',
  '*node_modules*',
  '**/node_modules/**',
  '*DS_Store*',
  '*.gem',
  'log/**',
  'tmp/**',
}
