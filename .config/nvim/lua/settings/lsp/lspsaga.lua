local saga = require("lspsaga")

saga.init_lsp_saga({
  saga_winblend = 10,
  code_action_icon = "¿",
  border_style = "plus",
  -- diagnostic_header = { "X ", "! ", "i ", "? " },
  definition_preview_icon = "» ",
  code_action_keys = {
    quit = "<Esc>",
    exec = "<CR>",
  },
  rename_action_quit = "<Esc>",
  max_preview_lines = 20,
  -- diagnostic_header = { " ", " ", " ", "ﴞ " },
})
