return {
  "ggandor/leap.nvim",
  enabled = true,
  keys = {
    { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  },
  opts = {},
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.add_default_mappings(true)
    vim.keymap.del({ "x", "o" }, "x")
    vim.keymap.del({ "x", "o" }, "X")
    -- bidirectional search
    vim.keymap.set("n", "s", function()
      local current_window = vim.fn.win_getid()
      require("leap").leap({ target_windows = { current_window } })
    end)
    -- Lightspeed colors
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    vim.api.nvim_set_hl(0, "LeapMatch", {
      -- For light themes, set to 'black' or similar.
      fg = "white",
      bold = true,
      nocombine = true,
    })

    vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
      fg = "red",
      bold = true,
      nocombine = true,
    })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
      fg = "blue",
      bold = true,
      nocombine = true,
    })
    -- Try it without this setting first, you might find you don't even miss it.
    require("leap").opts.highlight_unlabeled_phase_one_targets = true
  end,
}
