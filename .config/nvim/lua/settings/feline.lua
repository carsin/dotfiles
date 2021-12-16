local lsp = require('feline.providers.lsp')

local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local components = {
  active = {},
  inactive = {}
}
-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

local colors = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d79921',
  byellow = '#fadb2f',
  cyan = '#689d6a',
  oceanblue = '#458588',
  bgreen = '#b8bb26',
  green = '#98971a',
  orange = '#d65d0e',
  violet = '#b16286',
  magenta = '#d3869b',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#83a598',
  red = '#fb4934',
}

local vi_mode_colors = {
  NORMAL = 'bgreen',
  OP = 'green',
  INSERT = 'red',
  VISUAL = 'skyblue',
  BLOCK = 'skyblue',
  LINES = 'violet',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'cyan',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = '<|',
  OP = '<|',
  INSERT = '|>',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = '<|',
  SHELL = '<|',
  TERM = '<|',
  NONE = '<>'
}

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}

-- LEFT

-- vi-mode
table.insert(components.active[1], {
  provider = 'vi_mode',
  hl = function()
    local val = {}
    val.name = vi_mode_utils.get_mode_highlight_name()
    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'bg'
    val.style = 'bold'
    return val
  end,
  left_sep = '░▒▓█',
  right_sep = '█▓▒░',
  icon = ''
})

-- vi-symbol
table.insert(components.active[1], {
  provider = function()
    return vi_mode_text[vi_mode_utils.get_vim_mode()]
  end,
  hl = function()
    local val = {}
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'bg'
    -- val.style = 'bold'
    return val
  end,
  left_sep = ' ',
  right_sep = ' ',
})

-- filename
table.insert(components.active[1], {
  provider = 'file_info',
  file_modified_icon = '+',
  hl = {
    fg = 'white',
    bg = 'bg',
    -- style = 'bold'
  },
  type = "unique",
  right_sep = ''
})

-- gitBranch
table.insert(components.active[1], {
  provider = 'git_branch',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
})

-- diffAdd
table.insert(components.active[1], {
  provider = 'git_diff_added',
  icon = "+",
  hl = {
    fg = 'green',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
})

-- diffModified
table.insert(components.active[1], {
  provider = 'git_diff_changed',
  icon = "~",
  hl = {
    fg = 'yellow',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
})

-- diffRemove
table.insert(components.active[1], {
  provider = 'git_diff_removed',
  icon = "-",
  hl = {
    fg = 'red',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
})

-- RIGHT
table.insert(components.active[3], {
  provider = function()
    local max_len = 50
    local val = require("lsp-status").status()
    if string.len(val) >= max_len then
      val = "…" .. string.sub(val, 1, max_len) .. "…"
    end
    return val
  end,
  -- hl = "FlnStatus",
  -- hl = {
  --   fg = 'cyan',
  --   style = 'bold'
  -- },
})

-- diagnosticErrors
table.insert(components.active[3], {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('Error') end,
  icon = " E ",
  hl = {
    fg = 'red',
    -- style = 'bold'
  },
  right_sep = ''
})

-- diagnosticWarn
table.insert(components.active[3], {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('Warning') end,
  icon = " ! ",
  hl = {
    fg = 'yellow',
    -- style = 'bold'
  },
  right_sep = ''
})

-- diagnosticHint
table.insert(components.active[3], {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('Hint') end,
  icon = " ? ",
  hl = {
    fg = 'bgreen',
    -- style = 'bold'
  },
  right_sep = ' '
})

-- diagnosticInfo
table.insert(components.active[3], {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('Information') end,
  icon = " i ",
  hl = {
    fg = 'cyan',
    -- style = 'bold'
  },
  right_sep = ''
})

-- LspName
table.insert(components.active[3], {
  provider = 'lsp_client_names',
  icon = '',
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
  right_sep = ''
})

-- fileSize
table.insert(components.active[3], {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'red',
    bg = 'bg',
    -- style = 'bold'
  },
  left_sep = ' ',
  right_sep = '',
})

-- position
table.insert(components.active[3], {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
})

-- fileType
table.insert(components.active[3], {
  provider = 'file_type',
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    -- val.style = 'bold'
    return val
  end,
  right_sep = '',
  left_sep = '',
})


-- linePercent
table.insert(components.active[3], {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
})

-- scrollBar
table.insert(components.active[3], {
  provider = 'scroll_bar',
  hl = {
    fg = 'cyan',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
})

-- INACTIVE
-- LEFT
-- fileType
table.insert(components.inactive[1], {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
})

-- filename
table.insert(components.inactive[1], {
  provider = 'file_info',
  opts = {
    file_modified_icon = '+',
    file_readonly_icon = '-- READ ONLY',
    type = 'full-path',
  },
})

-- RIGHT
-- fileSize
table.insert(components.inactive[2], {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'white',
    bg = 'bg',
    -- style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
})

require('feline').setup({
  colors = colors,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
})