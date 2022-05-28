M = {}

-- ensure neorg is properly setup before treesitter loads its defaults
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
-- parser_configs.norg_meta = {
--     install_info = {
--         url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
--         files = { "src/parser.c" },
--         branch = "main"
--     },
-- }
--
-- parser_configs.norg_table = {
--     install_info = {
--         url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
--         files = { "src/parser.c" },
--         branch = "main"
--     },
-- }

M.setup = function()
  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- maps in normal mode to init the node/scope selection
        scope_incremental = "gnn", -- increment to the upper scope (as defined in locals.scm)
        node_incremental = "<TAB>", -- increment to the upper named parent
        node_decremental = "<S-TAB>", -- decrement to the previous node
      },
    },
    autopairs = { enable = true },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["il"] = "@loop.outer",
          ["al"] = "@loop.outer",
          ["icd"] = "@conditional.inner",
          ["acd"] = "@conditional.outer",
          ["acm"] = "@comment.outer",
          ["ast"] = "@statement.outer",
          ["isc"] = "@scopename.inner",
          ["iB"] = "@block.inner",
          ["aB"] = "@block.outer",
          ["p"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["gnf"] = "@function.outer",
          ["gnif"] = "@function.inner",
          ["gnp"] = "@parameter.inner",
          ["gnc"] = "@call.outer",
          ["gnic"] = "@call.inner",
        },
        goto_next_end = {
          ["gnF"] = "@function.outer",
          ["gniF"] = "@function.inner",
          ["gnP"] = "@parameter.inner",
          ["gnC"] = "@call.outer",
          ["gniC"] = "@call.inner",
        },
        goto_previous_start = {
          ["gpf"] = "@function.outer",
          ["gpif"] = "@function.inner",
          ["gpp"] = "@parameter.inner",
          ["gpc"] = "@call.outer",
          ["gpic"] = "@call.inner",
        },
        goto_previous_end = {
          ["gpF"] = "@function.outer",
          ["gpiF"] = "@function.inner",
          ["gpP"] = "@parameter.inner",
          ["gpC"] = "@call.outer",
          ["gpiC"] = "@call.inner",
        },
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = { ["DF"] = "@function.outer", ["CF"] = "@class.outer" },
      },
    },
    matchup = {
      enable = true,
    },
    lsp_interop = {
      enable = false,
    },
    ensure_installed = { "c", "rust", "lua", "norg", "comment" },
  })
end

M.get_hl = function()
  local highlighter = require("vim.treesitter.highlighter")
  local ts_utils = require("vim.treesitter.ts_utils")
  local buf = vim.api.nvim_get_current_buf()
  -- get row and column of cursor position
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- 1-based -> 0-based indexing
  row = row - 1
  -- column is different if in insert mode
  -- it's the column right of the cursor (if line) we don't want that
  if vim.api.nvim_get_mode().mode == "i" then
    col = col - 1
  end

  local self = highlighter.active[buf]
  if not self then
    return {}
  end

  local matches = {}

  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end

    -- get root of the ast (abstract syntax tree) note that all the nodes are subnodes of the root so this isn't the top of the file
    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    -- check if cursor_pos is inside of root
    if root_start_row > row or root_end_row < row then
      return
    end

    local query = self:get_query(tree:lang())

    if not query:query() then
      return
    end

    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

    -- go through all the captures inside root
    for capture, node, _ in iter do
      -- get highlight of capture
      local hl = query.hl_cache[capture]

      -- check if the node is at the cursor position
      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          -- get the highlight group and insert it into the table
          local general_hl = query:_get_hl_from_capture(capture)
          table.insert(matches, general_hl)
        end
      end
    end
  end, true)
  return matches
end

M.treesitter_context = function(width)
  if not packer_plugins["nvim-treesitter"] or packer_plugins["nvim-treesitter"].loaded == false then
    return " "
  end
  local type_patterns = {
    "class",
    "function",
    "method",
    "interface",
    "type_spec",
    "table",
    "if_statement",
    "for_statement",
    "for_in_statement",
    "call_expression",
    "comment",
  }

  if vim.o.ft == "json" then
    type_patterns = { "object", "pair" }
  end

  local f = require("nvim-treesitter").statusline({
    indicator_size = width,
    type_patterns = type_patterns,
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  -- lprint(context)
  if context == "vim.NIL" then
    return " "
  end

  return " " .. context
end

return M
