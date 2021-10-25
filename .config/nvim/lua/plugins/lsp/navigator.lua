require'navigator'.setup({
  width = 0.7, -- max width ratio (number of cols for the floating window) / (window width)
  height = 0.3, -- max list window height, 0.3 by default
  preview_height = 0.35, -- max height of preview windows
  -- border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, -- border style, can be one of 'none', 'single', 'double',
  border = 'shadow', -- border style, can be one of 'none', 'single', 'double',
  on_attach = require'plugins.lsp.lspconfig'.get_config().on_attach,
  default_mapping = true,  -- set to false if you will remap every key
  keymaps = {{key = "gK", func = "declaration()"}}, -- a list of key maps
  -- this kepmap gK will override "gD" mapping function declaration()  in default kepmap
  treesitter_analysis = true, -- treesitter variable context
  transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it
  icons = {
    -- Code action
    code_action_icon = "🏏",
    -- Diagnostics
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = "🈲",
    -- refer to lua/navigator.lua for more icons setups
  },
  lsp_installer = true, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
  lsp = {
    code_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
    code_lens_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
    format_on_save = false, -- set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
    diagnostic_scroll_bar_sign = {'▃', '▆', '█'}, -- experimental:  diagnostic status in scroll bar area; set to nil to disable the diagnostic sign,
    diagnostic_virtual_text = false,  -- show virtual for diagnostic message
    diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
    disply_diagnostic_qf = false, -- always show quickfix if there are diagnostic errors, set to false if you  want to
    -- tsserver = {
    --   filetypes = {'typescript'} -- disable javascript etc,
    --   -- set to {} to disable the lspclient for all filetypes
    -- },
    -- sumneko_lua = {
    --   sumneko_root_path = vim.fn.expand("$HOME") .. "/github/sumneko/lua-language-server",
    --   sumneko_binary = vim.fn.expand("$HOME") .. "/github/sumneko/lua-language-server/bin/macOS/lua-language-server",
    -- },
  }
})


