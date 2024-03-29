local M = {
  'akinsho/bufferline.nvim',
}

M.config = function()
  local colors = {
    bg = "#282828",
    black = "#282828",
    yellow = "#d79921",
    byellow = "#fadb2f",
    cyan = "#689d6a",
    oceanblue = "#458588",
    bgreen = "#b8bb26",
    green = "#98971a",
    orange = "#d65d0e",
    violet = "#b16286",
    magenta = "#d3869b",
    white = "#a89984",
    fg = "#a89984",
    skyblue = "#83a598",
    red = "#fb4934",
  }

  require("bufferline").setup {
    options = {
      mode = "buffers",
      always_show_bufferline = false,
      indicator = {
        style = 'icon',
        icon = " > ",
      },
      show_close_icon = false,
      buffer_close_icon = "", -- 
      modified_icon = "+",
      close_icon = "", -- 
      left_trunc_marker = "…",
      right_trunc_marker = "…",
      max_name_length = 22,
      max_prefix_length = 16, -- prefix used when a buffer is de-duplicated
      tab_size = 0,
      enforce_regular_tabs = false,
      close_command = "lua require('bufdelete').bufdelete(0, true)",
      right_mouse_command = "vertical sbuffer %d", -- vertical split
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      sort_by = "id",
      custom_filter = function(buf) -- don't show [No Name] buffers
        if vim.fn.bufname(buf) ~= "NvimTree" and vim.fn.bufname(buf) ~= "" then
          return true
        end
      end,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and "E " or (e == "warning" and "! " or "? " or "i ")
          s = s .. n .. sym
        end
        if context.buffer:current() then
          return s
        end
        return ''
      end,
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
      --   local icon = level:match("error") and "! " or "? "
      --   return " " .. icon .. count
      -- end,
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Files",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      custom_areas = { -- LSP diagnostics in top right
        right = function()
          local result = {}
          local error = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.ERROR } })
          local warning = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
          local information = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.INFO } })
          local hint = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.HINT } })

          if error ~= 0 then
            table.insert(result, { text = " E " .. error, foreground = colors.red })
          end

          if warning ~= 0 then
            table.insert(result, { text = " ! " .. warning, foreground = colors.yellow })
          end

          if hint ~= 0 then
            table.insert(result, { text = " ? " .. hint, foreground = colors.bgreen })
          end

          if info ~= 0 then
            table.insert(result, { text = " i " .. info, foreground = colors.cyan })
          end
          return result
        end,
      },
    },
  }
end

return M;
