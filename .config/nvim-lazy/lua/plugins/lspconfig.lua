return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = {
      underline = true,
      update_in_insert = false,
      signs = true,
      virtual_text = false,
      severity_sort = true,
    }
  end,
  config = function(plugin, opts)
    plugin._.super.config(plugin, opts)
    local signs = { Error = "X ", Warn = "! ", Hint = "? ", Info = "i " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
