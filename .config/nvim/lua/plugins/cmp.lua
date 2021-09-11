local cmp = require 'cmp'
local lspkind = require('lspkind')
-- local luasnip = require("luasnip")

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      -- luasnip.lsp_expand(args.body)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if check_back_space() then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
      elseif has_words_before() and vim.fn['vsnip#available']() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '', true)
      elseif vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n', true)
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function()
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n', true)
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '', true)
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vsnip' },
    { name = 'calc' },
    { name = 'buffer' },
    { name = 'spell' },
    { name = 'tmux', opts = { all_panes = false }},
  },
  -- completion = {
  --   completeopt = 'menu,menuone,noinsert',
  -- },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[Snippet]",
        tmux = "[Tmux]",
        path = "[Path]",
        spell = "[Spell]",
        calc = "[Calc]",
      })[entry.source.name]
      return vim_item
    end,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    winhighlight = 'FloatBorder:TelescopeBorder',
  },
  experimental = {
    ghost_text = true,
  }
}

