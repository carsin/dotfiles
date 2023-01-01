require("auto-save").setup({
  enabled = true,
  execution_message = {},
  events = { "InsertLeave", "TextChanged", "WinLeave", "BufWinLeave" },
  write_all_buffers = false,
  on_off_commands = true,
  clean_command_line_interval = 0,
  debounce_delay = 750,
  conditions = {
    exists = true,
    filename_is_not = {},
    filetype_is_not = {},
    modifiable = true
  },
})
