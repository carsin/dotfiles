require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" }
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
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
  },
  matchup = {
    enable = true,
  },
}

require('spellsitter').setup {
  enable = {'markdown', 'md'},
}
