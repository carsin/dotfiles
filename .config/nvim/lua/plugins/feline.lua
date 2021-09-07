local lsp = require('feline.providers.lsp')

local vi_mode_utils = require('feline.providers.vi_mode')

local properties = {
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
  }
}

local components = {
  left = {active = {}, inactive = {}},
  mid = {active = {}, inactive = {}},
  right = {active = {}, inactive = {}}
}

local colors = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d79921',
  cyan = '#689d6a',
  oceanblue = '#458588',
  green = '#b8bb26',
  orange = '#d65d0e',
  violet = '#b16286',
  magenta = '#d3869b',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#83a598',
  red = '#fb4934',
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  VISUAL = 'skyblue',
  BLOCK = 'skyblue',
  LINES = 'magenta',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
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

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

properties.force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

properties.force_inactive.buftypes = {
  'terminal'
}

-- LEFT

-- vi-mode
components.left.active[1] = {
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
}
-- vi-symbol
components.left.active[2] = {
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
}
-- filename
components.left.active[3] = {
  provider = 'file_info',
  file_modified_icon = "+",
  hl = {
    fg = 'white',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ''
}
-- gitBranch
components.left.active[4] = {
  provider = 'git_branch',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
}
-- diffAdd
components.left.active[5] = {
  provider = 'git_diff_added',
  icon = "+",
  hl = {
    fg = 'green',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
}
-- diffModified
components.left.active[6] = {
  provider = 'git_diff_changed',
  icon = "~",
  hl = {
    fg = 'yellow',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
}
-- diffRemove
components.left.active[7] = {
  provider = 'git_diff_removed',
  icon = "-",
  hl = {
    fg = 'red',
    bg = 'bg',
    -- style = 'bold'
  },
  right_sep = ' '
}

-- MID

-- LspName
components.mid.active[1] = {
  provider = 'lsp_client_names',
  icon = '',
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ''
}
-- diagnosticErrors
components.mid.active[2] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('Error') end,
  icon = " E ",
  hl = {
    fg = 'red',
    -- style = 'bold'
  }
}
-- diagnosticWarn
components.mid.active[3] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('Warning') end,
  icon = " ! ",
  hl = {
    fg = 'orange',
    -- style = 'bold'
  }
}
-- diagnosticHint
components.mid.active[4] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('Hint') end,
  icon = " ? ",
  hl = {
    fg = 'green',
    -- style = 'bold'
  }
}
-- diagnosticInfo
components.mid.active[5] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('Information') end,
  hl = {
    fg = 'cyan',
    -- style = 'bold'
  }
}

-- RIGHT

-- fileIcon
-- components.right.active[1] = {
--   provider = function()
--     local filename = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
--     if icon == nil then
--       icon = ''
--     end
--     return icon
--   end,
--   hl = function()
--     local val = {}
--     local filename = vim.fn.expand('%:t')
--     local extension = vim.fn.expand('%:e')
--     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
--     if icon ~= nil then
--       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
--     else
--       val.fg = 'white'
--     end
--     val.bg = 'bg'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' '
-- }
-- fileType
components.right.active[1] = {
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
  right_sep = ' '
}
-- fileSize
components.right.active[2] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'red',
    bg = 'bg',
    -- style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
}
-- fileFormat
components.right.active[3] = {
  provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
}
-- fileEncode
components.right.active[4] = {
  provider = 'file_encoding',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
}

components.right.active[5] = {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
}
-- linePercent
components.right.active[6] = {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' ',
}
-- scrollBar
components.right.active[7] = {
  provider = 'scroll_bar',
  hl = {
    fg = 'cyan',
    bg = 'bg',
  },
  left_sep = ' ',
}

-- INACTIVE

-- fileType
components.left.inactive[1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    -- style = 'bold'
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
}

-- filename
components.left.inactive[2] = {
  icon = '',
  provider = 'file_info',
  file_modified_icon = "+",
}

-- fileSize
components.right.inactive[1] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'white',
    bg = 'bg',
    -- style = 'bold'
  },
  left_sep = ' ',
  right_sep = ' '
}

require('feline').setup({
  colors = colors,
  default_bg = bg,
  default_fg = fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  properties = properties,
})
