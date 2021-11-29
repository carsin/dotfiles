local autosave = require("autosave")

autosave.setup({
  enabled = true,
  execution_message = "",
  events = { "InsertLeave", "CursorHold", "BufWinLeave" },
  write_all_buffers = false,
  on_off_commands = true,
  clean_command_line_interval = 0,
  debounce_delay = 800,
  conditions = {
      exists = true,
      filename_is_not = {},
      filetype_is_not = {},
      modifiable = true
  },
})
