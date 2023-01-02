local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = "BufEnter", -- this makes the plugin work for some reason?
}

M.config = function()
  require('gitsigns').setup {
    signcolumn = true,
    keymaps = {
      noremap = false,
    },
    -- watch_index = {
    --   interval = 1000,
    --   follow_files = true
    -- },
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 1000,
    },
    current_line_blame_formatter_opts = {
      relative_time = true
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    }
  }
end

return M;
