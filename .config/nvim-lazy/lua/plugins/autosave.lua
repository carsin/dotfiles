return { -- AutoSaves the buffer
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  keys = {
    { "<leader>uS", ":ASToggle<CR>", desc = "Toggle auto-save" },
  },
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = { enabled = false },
      trigger_events = { -- See :h events
        immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
      },
      write_all_buffers = false,
      clean_command_line_interval = 0,
      debounce_delay = 1500,
      conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = {},
        modifiable = true,
      },
    })
  end,
}
