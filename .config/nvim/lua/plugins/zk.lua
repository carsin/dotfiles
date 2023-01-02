local M = {
  "mickael-menu/zk-nvim",
}
M.config = function()
  local lspc = require("plugins.lspconfig").get_config()
  local zk = require("zk")
  local commands = require("zk.commands")
  -- add :ZkOrphans to list unreferenced files
  commands.add("ZkOrphans", function(options)
    options = vim.tbl_extend("force", { orphan = true }, options or {})
    zk.edit(options, { title = "Zk Orphans" })
  end)

  -- add :ZkRecents
  local function make_edit_fn(defaults, picker_options)
    return function(options)
      options = vim.tbl_extend("force", defaults, options or {})
      zk.edit(options, picker_options)
    end
  end

  commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
  commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

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
end

return M
