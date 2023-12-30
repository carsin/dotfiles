return {
  "nvim-telescope/telescope.nvim",
  keys = {},
  -- change some options
  opts = {
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close,
          ["<C-q>"] = require("telescope.actions").close,
          -- ["J"] = require("telescope.actions").move_selection_next,
          -- ["K"] = require("telescope.actions").move_selection_previous,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_next,
          ["<s-tab>"] = require("telescope.actions").toggle_selection
            + require("telescope.actions").move_selection_previous,
        },
        n = {
          ["<Esc>"] = require("telescope.actions").close,
          ["<C-q>"] = require("telescope.actions").close,
          ["q"] = require("telescope.actions").close,
          ["Q"] = require("telescope.actions").close,
          ["<tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_next,
          ["<s-tab>"] = require("telescope.actions").toggle_selection
            + require("telescope.actions").move_selection_previous,
        },
      },
    },
  },
}
