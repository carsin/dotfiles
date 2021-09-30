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

require("bufferline").setup{
  options = {
    always_show_bufferline = true,
    indicator_icon = ' > ',
    buffer_close_icon = '',
    modified_icon = '+',
    close_icon = '',
    left_trunc_marker = '…',
    right_trunc_marker = '…',
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 20,
    enforce_regular_tabs = true,
    show_close_icon = false,
    close_command = "lua require('bufdelete').bufdelete(0, true)",
    right_mouse_command = "vertical sbuffer %d", -- vertical split
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and "! " or "? "
      return " " .. icon .. count
    end,
    numbers = function(opts)
      return string.format('%s.', opts.ordinal)
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Files",
        highlight = "Directory",
        text_align = "left"
      }
    },
    custom_areas = {  -- LSP diagnostics in top right
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          table.insert(result, {text = " E " .. error, guifg = colors.red})
        end

        if warning ~= 0 then
          table.insert(result, {text = " ! " .. warning, guifg = colors.yellow})
        end

        if hint ~= 0 then
          table.insert(result, {text = " ? " .. hint, guifg = colors.bgreen})
        end

        if info ~= 0 then
          table.insert(result, {text = " i " .. info, guifg = colors.cyan})
        end
        return result
      end,
    }
  },
}
