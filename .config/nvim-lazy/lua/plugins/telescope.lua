local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "danielfalk/smart-open.nvim",
      branch = "0.2.x",
      config = function()
        require("telescope").load_extension("smart_open")
      end,
      dependencies = {
        "kkharji/sqlite.lua",
        -- Only required if using match_algorithm fzf
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
        { "nvim-telescope/telescope-fzy-native.nvim" },
      },
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
  },
  keys = {
    {
      ";;",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
      desc = "Resume the previous telescope picker",
    },
    {
      ";d",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
      desc = "Diagnostics for all open buffers",
    },
    {
      ";f",
      Util.telescope("files", { cwd = false }),
      desc = "Search for file (cwd)",
    },
    {
      ";e",
      function()
        local telescope = require("telescope")

        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          initial_mode = "normal",
          grouped = true,
          previewer = true,
          layout_config = { height = 40 },
        })
      end,
      desc = "Open file browser",
    },
    {
      ";h",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
      desc = "List help tags and opens a new window with the relevant help info on <cr>",
    },
    {
      ";s",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Project)",
    },
    {
      ";r",
      function()
        require("telescope").extensions.smart_open.smart_open()
      end,
      desc = "Recent Files",
    },
    { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>fF", Util.telescope("files"), desc = "Find Files (root dir)" },
    {
      "<leader>fr",
      function()
        require("telescope").extensions.smart_open.smart_open()
      end,
      desc = "Recent Files",
    },
    { "<leader>sf", Util.telescope("live_grep"), desc = "Grep" },
    { "<leader>ss", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader><leader>", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          symbols = require("lazyvim.config").get_kind_filter(),
        })
      end,
      desc = "Goto Symbol (Project)",
    },
  },
  opts = { -- change some options
    extensions = {
      smart_open = {
        show_scores = true,
      },
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
      },
    },
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
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
          ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
          ["<C-Down>"] = require("telescope.actions").cycle_history_next,
          ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
          ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
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
