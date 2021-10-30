local border = { {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"}, {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"}, {"╰", "FloatBorder"}, {"│", "FloatBorder"} }
local sumneko = require('plugins.lsp.sumneko')
local nvim_lsp = require'lspconfig'
local lsp_installer = require("nvim-lsp-installer")
local M = {}

require('dd').setup({
  timeout = 250,
})

M.on_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = nil })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = nil })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = true,
      virtual_text = false,
    }
  )
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc') -- Enable completion triggered by <c-x><c-o>
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>xa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua require "telescope.builtin".lsp_code_actions()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>zz', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>zz', opts)
  buf_set_keymap("n", "gq", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- buf_set_keymap("v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>", opts) // TODO: Replace with neoformat
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

M.get_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  return {
    flags = {
      debounce_text_changes = 250,
      allow_incremental_sync = true,
    },
    handlers = {},
    capabilities = capabilities,
    -- on_init = on_init,
    on_attach = M.on_attach,
  }
end

local servers = {
	"clangd",
	"sumneko_lua",
	"rust_analyzer",
	-- "jdtls",
}

for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	if ok then -- Check that the server is supported in nvim-lsp-installer
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

lsp_installer.on_server_ready(function(server)
  local opts = M.get_config()
  local server_opts = {
    ["sumneko_lua"] = function()
      opts = M.get_config()
      opts.settings = sumneko.lua_settings
    end,
  }

  if server.name == "rust_analyzer" then -- override rust_analyzer set up with rust-tools' implement
    local rust_opts = require'plugins.lsp.rust-tools'.opts
    rust_opts.server = vim.tbl_deep_extend("force", server:get_default_options(), {
        on_attach = opts.on_attach,
        capabilities = opts.capaibilities,
        flags = opts.flags,
        handlers = opts.handlers,
    })
    require("rust-tools").setup(rust_opts)
  elseif server.name == "jdtls" then -- override jdtls
    local jdtls_opts = require'plugins.lsp.jdtls'.config
    require("jdtls").start_or_attach(jdtls_opts)
  else
      -- check to see if any custom server_opts exist for the LSP server
      server:setup(server_opts[server.name] and server_opts[server.name]() or opts)
      vim.cmd [[ do User LspAttachBuffers ]]
  end
end)

return M
