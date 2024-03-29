local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-cmdline",
    "Furkanzmc/sekme.nvim",
    "andersevenrud/cmp-tmux",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    { -- autopairs
      "windwp/nvim-autopairs",
      config = function()
        require('nvim-autopairs').setup {
          map_cr = true,
          map_complete = true,
          auto_select = true,
          -- ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
          ignored_next_char = [=[[%%%'%[%"%.%`%$]]=],
          check_ts = truew,
          ts_config = {
            lua = { 'string' },
            javascript = { 'template_string' },
          },
          disable_filetype = { 'TelescopePrompt', 'vim', "markdown" },
        }
      end,
    },
  },
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")

  -- autopairs: If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
  -- cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  -- move past commas and semicolons
  for _, punct in pairs { ",", ";" } do
    npairs.add_rules {
      Rule("", punct)
          :with_move(function(opts) return opts.char == punct end)
          :with_pair(function() return false end)
          :with_del(function() return false end)
          :with_cr(function() return false end)
          :use_key(punct)
    }
  end
  npairs.add_rules({
    Rule("<", ">", "rust")
        :with_pair(require("nvim-autopairs.conds").not_after_regex("="))-- don't add a pair if the next character is =
  })

  cmp.setup({
    experimental = {
      -- native_menu = false,
      -- ghost_text = {
      --   hl_group = "LspCodeLens"
      -- },
    },
    completion = {
      -- completeopt = "menu,menuone,noinsert",
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      keyword_length = 1,
    },
    formatting = {
      format = require("plugins.lsp.icons").cmp_format();
    },
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
end

return M;
