local border = { {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"}, {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"}, {"╰", "FloatBorder"}, {"│", "FloatBorder"} }
local nvim_lsp = require'lspconfig'
local lspinstall = require'lspinstall'
local sumneko = require('plugins.lsp.sumneko')
local M = {}

local function on_attach(client, bufnr)
  vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = nil })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = nil })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
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
  buf_set_keymap('n', 'gr', '<cmd>TroubleToggle lsp_references<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>xa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>zz', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>zz', opts)
  buf_set_keymap("n", "gq", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
    on_attach = on_attach,
  }
end

local function setup_servers()
  lspinstall.setup()
  local servers = lspinstall.installed_servers()
  for _, server in pairs(servers) do
    local config = M.get_config()

    if server == "lua" then
      config.settings = sumneko.lua_settings
    end
    if server == 'java' then
      goto continue -- is set up with jdtls
    end
    nvim_lsp[server].setup(config)
    ::continue::
  end
end

-- automatically setup servers again after `:LspInstall <server>`
setup_servers()
lspinstall.post_install_hook = function()
  setup_servers() -- makes sure the new server is setup in lspconfig
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

return M
