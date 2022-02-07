local lspc = require("settings.lsp.lspconfig").get_config()
local zk = require("zk")
local commands = require("zk.commands")
local M = {}

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

-- infile keymappings
M.set_mappings = function()
  if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
    local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
    local opts = { noremap=true, silent=false }
    -- Open the link under the caret.
    map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- Create a new note after asking for its title.
    -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
    map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
    -- Alternative for backlinks using pure LSP and showing the source context.
    --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
    -- Preview a linked note.
    map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- Open the code actions for a visual selection.
    map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
  end
end

return M

