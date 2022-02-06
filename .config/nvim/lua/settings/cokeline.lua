local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')

local str_rep = string.rep

local green = vim.g.terminal_color_4
local yellow = vim.g.terminal_color_3

local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local min_buffer_width = 23

local components = {
  separator = {
    text = ' ',
    hl = { bg = "#282828" },
    truncation = { priority = 1 },
  },

  space = {
    text = ' ',
    truncation = { priority = 1 },
  },

  devicon = {
    text = function(buffer)
      return buffer.devicon.icon
    end,
    hl = {
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    truncation = { priority = 1 },
  },

  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    hl = {
      fg = function(buffer)
        return
          (buffer.diagnostics.errors ~= 0 and errors_fg)
          or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
          or nil
      end,
    },
    truncation = { priority = 1 },
  },

  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    hl = {
      fg = comments_fg,
      style = 'italic',
    },
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },

  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    hl = {
      fg = function(buffer)
        return
          (buffer.diagnostics.errors ~= 0 and errors_fg)
          or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
          or nil
      end,
      style = function(buffer)
        return
          ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
            and 'bold,underline')
          or (buffer.is_focused and 'bold')
          or (buffer.diagnostics.errors ~= 0 and 'underline')
          or nil
      end
    },
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    hl = {
      fg = function(buffer)
        return buffer.is_modified and green or nil
      end
    },
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

local get_remaining_space = function(buffer)
  local used_space = 0
  for _, component in pairs(components) do
    used_space = used_space + vim.fn.strwidth(
      (type(component.text) == 'string' and component.text)
      or (type(component.text) == 'function' and component.text(buffer))
    )
  end
  return math.max(0, min_buffer_width - used_space)
end

local left_padding = {
  text = function(buffer)
    local remaining_space = get_remaining_space(buffer)
    return str_rep(' ', remaining_space / 2 + remaining_space % 2)
  end,
}

local right_padding = {
  text = function(buffer)
    local remaining_space = get_remaining_space(buffer)
    return str_rep(' ', remaining_space / 2)
  end,
}

require('cokeline').setup({
  show_if_buffers_are_at_least = 2,

  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    focus_on_delete = 'next',
    new_buffers_position = 'next',
  },

  rendering = {
    max_buffer_width = 23,
    left_sidebar = {
      filetype = 'NvimTree',
      components = {
        {
          text = '  NvimTree',
          hl = {
            fg = yellow,
            bg = get_hex('NvimTreeNormal', 'bg'),
            style = 'bold'
          }
        },
      }
    },
  },

  default_hl = {
    focused = {
      fg = get_hex('Normal', 'fg'),
      bg = get_hex('NvimTreeNormal', 'bg'),
    },
    unfocused = {
      fg = get_hex('Comment', 'fg'),
      bg = get_hex('NvimTreeNormal', 'bg'),
    },
  },

  components = {
    components.separator,
    left_padding,
    components.devicon,
    components.index,
    components.unique_prefix,
    components.filename,
    components.space,
    right_padding,
    components.close_or_unsaved,
  },
})

local map = vim.api.nvim_set_keymap

map('n', '<leader>h',  '<Plug>(cokeline-focus-prev)',  { silent = true })
map('n', '<leader>l',  '<Plug>(cokeline-focus-next)',  { silent = true })
map('n', '<leader>H', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<leader>L', '<Plug>(cokeline-switch-next)', { silent = true })

for i = 1,9 do
  map('n', ('<F%s>'):format(i),      ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
  map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end
