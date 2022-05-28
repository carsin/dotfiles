local cmp = require("cmp")
local luasnip = require("luasnip")
-- local kind = cmp.lsp.CompletionItemKind

local icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  -- Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  -- Reference = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  -- Struct = "",
  Struct = "פּ",
  -- Event = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

-- autopairs: If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- load friendlysnippets into LuaSnip
vim.cmd([[ lua require("luasnip/loaders/from_vscode").lazy_load() ]])

cmp.setup({
  experimental = {
    native_menu = false,
    ghost_text = false,
  },
  confirmation = {
    get_commit_characters = function()
      return {}
    end,
  },
  completion = {
    -- completeopt = "menu,menuone,noinsert",
    -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.menu = vim_item.kind
      vim_item.kind = icons[vim_item.kind]

      return vim_item
    end,
  },
  -- formatting = {
  --   format = require("lspkind").cmp_format({
  --     with_text = true,
  --     mode = "symbol", -- show only symbol annotations
  --     maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --     menu = {
  --       buffer = "[Buffer]",
  --       nvim_lua = "[VimApi]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[LuaSnip]",
  --       tmux = "[Tmux]",
  --       path = "[Path]",
  --       -- spell = "[Spell]",
  --       calc = "[Calc]",
  --       latex_symbols = "[Latex]",
  --       crates = "[Crates]",
  --       neorg = "[Org]",
  --     },
  --     before = function(entry, vim_item)
  --       return vim_item
  --     end,
  --   }),
  -- },
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
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping.confirm {
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    },
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
  sorting = {
    priority_weight = 1.0,
    comparators = {
      -- compare.score_offset, -- not good at all
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      cmp.config.compare.offset,
      cmp.config.compare.order,
      -- compare.scopes, -- what?
      -- compare.sort_text,
      -- compare.exact,
      -- compare.kind,
      -- compare.length, -- useless
    }
  },
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
  preselect = cmp.PreselectMode.None,
})

-- cmdline
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
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
