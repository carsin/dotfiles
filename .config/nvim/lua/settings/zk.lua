local lspc = require'settings.lsp.lspconfig'.get_config()


require("zk").setup({
  picker = "telescope",
  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      on_attach = lspc.on_attach,
      capabilities = lspc.capabilities,
      flags = lspc.flags,
    },

    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

