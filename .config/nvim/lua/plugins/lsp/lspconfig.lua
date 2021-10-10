local border = { {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"}, {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"}, {"╰", "FloatBorder"}, {"│", "FloatBorder"} }
local api = vim.api
local M = {}
local lspc = {}
local jdtls = require 'jdtls'
local nvim_lsp = require 'lspconfig'
local root_markers = {'gradlew', '.git'}

do -- Ensure limited instances / proper start of language server
  local lsp_client_ids = {} -- id is filetype│root_dir
  function lspc.start(config, root_markers)
    local root_dir = require('jdtls.setup').find_root(root_markers)
    if not root_dir then return end
    local cmd = config.cmd[1]
    if tonumber(vim.fn.executable(cmd)) == 0 then
      api.nvim_command(string.format(
        ':echohl WarningMsg | redraw | echo "No LSP executable: %s" | echohl None', cmd))
      return
    end
    config['root_dir'] = root_dir
    local lsp_id = tostring(vim.bo.filetype) .. "│" .. root_dir
    local client_id = lsp_client_ids[lsp_id]
    if not client_id then
      client_id = lsp.start_client(config)
      lsp_client_ids[lsp_id] = client_id
    end
    local bufnr = api.nvim_get_current_buf()
    lsp.buf_attach_client(bufnr, client_id)
  end
  function lspc.restart()
    for id, client_id in pairs(lsp_client_ids) do
      local client = vim.lsp.get_client_by_id(client_id)
      if client then
        local bufs = vim.lsp.get_buffers_by_client_id(client_id)
        client.stop()
        local new_client_id = lsp.start_client(client.config)
        lsp_client_ids[id] = new_client_id
        for _, buf in pairs(bufs) do
          lsp.buf_attach_client(buf, new_client_id)
        end
      end
    end
  end
  M.restart = lspc.restart
end

local function on_init(client)
  lsp.util.text_document_completion_list_to_complete_items = require('lsp_compl').text_document_completion_list_to_complete_items
  if client.config.settings then
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

local on_attach = function(bufnr)
  -- vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
      virtual_text = false,
    }
  )
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
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
  buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


local function get_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  return {
    flags = {
      debounce_text_changes = 250,
      allow_incremental_sync = true,
    };
    handlers = {},
    capabilities = capabilities;
    on_init = on_init;
    on_attach = on_attach;
  }
end

function M.add_client(cmd, opts)
  local config = get_config()
  config['name'] = opts and opts.name or cmd[1]
  config['cmd'] = cmd
  lspc.start(config, opts and opts.root or {'.git'})
end

-- Enable the following language servers
local servers = { 'rust_analyzer', 'pyright', 'ccls', }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = get_config().capabilities,
    flags = { debounce_text_changes = 250 },
  }
end

-- LOAD SUMNEKO --
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- Set up sumneko
nvim_lsp.sumneko_lua.setup {
  cmd = { vim.fn.getenv("HOME")..'/.local/bin/lua-language-server/bin/macOS/lua-language-server', '-E', vim.fn.getenv("HOME")..'/.local/bin/lua-language-server' .. '/main.lua' },
  on_attach = on_attach,
  -- capabilities = capabilities,
  capabilities = get_config().capabilities,
  flags = { debounce_text_changes = 250 },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local function jdtls_on_attach(client, bufnr)
  on_attach(client, bufnr, {
    server_side_fuzzy_completion = true,
    trigger_on_delete = false
  })
  local opts = { silent = true; }
  -- jdtls.setup_dap({hotcodereplace = 'auto'})
  jdtls.setup.add_commands()
  local nnoremap = function(lhs, rhs)
    api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
      virtual_text = false,
    }
  )
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }
  -- Global lsp
  -- TODO: Organize
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<c-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>xa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>zz', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>zz', opts)
  buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- JDTLS Unique
  nnoremap("<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
  nnoremap("<leader>df", "<Cmd>lua require('me.dap'); require'jdtls'.test_class()<CR>")
  nnoremap("<leader>dn", "<Cmd>lua require('me.dap'); require'jdtls'.test_nearest_method()<CR>")
  nnoremap("crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
  nnoremap("crv", "<Cmd>lua require('jdtls').extract_variable()<CR>")
  nnoremap("crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
  nnoremap("crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
  nnoremap("crc", "<Cmd>lua require('jdtls').extract_constant()<CR>")
end

function M.start_jdtls()
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local home = os.getenv('HOME')
  local workspace_folder = home .. "/files/dev/projects/java" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = get_config()
  config.flags.server_side_fuzzy_completion = true
  config.settings = {
    java = {
      signatureHelp = { enabled = true };
      contentProvider = { preferred = 'fernflower' };
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
      codeGeneration = {
        useBlocks = true,
        generateComments = true,
      };
    };
  }
  config.cmd = { "jdt-language-server" }
  config.on_attach = jdtls_on_attach
  --  External jars
  local jar_patterns = {
    home .. '/.local/bin/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    home .. '/.local/bin/dgileadi/vscode-java-decompiler/server/*.jar',
    home .. '/.local/bin/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
    home .. '/.local/bin/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
    home .. '/.local/bin/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
  }
  -- Gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
  local plugin_path = home .. '/.local/bin/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
  local bundle_list = vim.tbl_map(
    function(x) return require('jdtls.path').join(plugin_path, x) end, {
      'org.eclipse.jdt.junit4.runtime_*.jar',
      'org.eclipse.jdt.junit5.runtime_*.jar',
      'org.junit.jupiter.api*.jar',
      'org.junit.jupiter.engine*.jar',
      'org.junit.jupiter.migrationsupport*.jar',
      'org.junit.jupiter.params*.jar',
      'org.junit.vintage.engine*.jar',
      'org.opentest4j*.jar',
      'org.junit.platform.commons*.jar',
      'org.junit.platform.engine*.jar',
      'org.junit.platform.launcher*.jar',
      'org.junit.platform.runner*.jar',
      'org.junit.platform.suite.api*.jar',
      'org.apiguardian*.jar'
    }
  )
  vim.list_extend(jar_patterns, bundle_list)
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
      if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
        table.insert(bundles, bundle)
      end
    end
  end
  local extendedClientCapabilities = jdtls.extendedClientCapabilities;
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
  config.init_options = {
    bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities;
  }
  -- mute; having progress reports is enough
  -- config.handlers['language/status'] = function() end
  jdtls.start_or_attach(config)
end

return M
