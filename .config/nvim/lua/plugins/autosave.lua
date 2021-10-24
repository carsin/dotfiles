local autosave = require("autosave")

autosave.setup({
  enabled = true,
  execution_message = "",
  events = { "InsertLeave", "CursorHold" },
  write_all_buffers = false,
  on_off_commands = true,
  clean_command_line_interval = 0,
  debounce_delay = 600,
  conditions = {
      exists = true,
      filename_is_not = {},
      filetype_is_not = {},
      modifiable = true
  },
})
