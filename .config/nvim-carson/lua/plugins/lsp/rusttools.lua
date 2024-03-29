-- local extension_path = '/home/carson/.local/share/nvim/user_servers/codelldb/extension/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
local M = {}

M.opts = {
  tools = { -- rust-tools options
    -- hover_with_actions = true, -- Whether to show hover actions inside the hover window
    runnables = { use_telescope = true },
    debuggables = { use_telescope = true },
    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true, -- Automatically set inlay hints (type hints)
      only_current_line = true,
      only_current_line_autocmd = "CursorHold,CursorHoldI",
      show_parameter_hints = true, -- whether to show parameter hints with the inlay hints or not
      parameter_hints_prefix = "params: ", -- prefix for parameter hints
      other_hints_prefix = "-> ", -- prefix for all the other hints (type, chaining)
      max_len_align = true, -- whether to align to the length of the longest line in the file
      max_len_align_padding = 1, -- padding from the left if max_len_align is true
      right_align = false, -- whether to align to the extreme right or not
      right_align_padding = 7, -- padding from the right if right_align is true
      highlight = "Comment", -- The color of the hints
    },

    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      -- border = {
      --     {"╭", "FloatBorder"}, {"─", "FloatBorder"},
      --     {"╮", "FloatBorder"}, {"│", "FloatBorder"},
      --     {"╯", "FloatBorder"}, {"─", "FloatBorder"},
      --     {"╰", "FloatBorder"}, {"│", "FloatBorder"}
      -- },

      -- whether the hover action window gets automatically focused
      auto_focus = false
    }
  },
  server = {
    settings = {
      ["rust-analyzer"] = {
        inlayHints = { locationLinks = false }, -- currently broken with rust-tools
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--all-targets",
            "--all-features",
            "--message-format=json",
            "--no-deps",
          },
        },
      },
    },
  },
  -- dap = { -- use codeLLDB
  --   adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  -- }
}

return M;
