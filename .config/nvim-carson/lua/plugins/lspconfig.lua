local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mfussenegger/nvim-jdtls",
    "p00f/clangd_extensions.nvim",
    "williamboman/mason.nvim", -- lsp installer
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "simrat39/rust-tools.nvim",
    "RRethy/vim-illuminate", -- highlight matches of symbol under cursor
    "SmiteshP/nvim-navic", -- lsp code context winbar component
    { -- signature
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup({
          floating_window_above_cur_line = true,
          hint_prefix = "? ",
        })
      end,
    },
    { url = "https://gitlab.com/yorickpeterse/nvim-dd" },
  },
}

M.get_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.workspace.configuration = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  require("cmp_nvim_lsp").default_capabilities(capabilities)
  return {
    flags = {
      debounce_text_changes = 350,
      allow_incremental_sync = true,
    },
    handlers = {},
    capabilities = capabilities,
    -- on_init = on_init,
    on_attach = M.on_attach,
  }
end

M.config = function()
  local navic = require("nvim-navic")
  local lspconfig = require("lspconfig")

  -- setup navbar context
  navic.setup {
    icons = require("plugins.lsp.icons").icons;
    highlight = false,
    separator = ' > ',
    depth_limit = 7, -- limit for amount of context shown
    depth_limit_indicator = "…", -- indicator used when context hits depth limit
  }

  -- global config
  vim.diagnostic.config({
    underline = true,
    virtual_text = {
      source = "if_many",
      prefix = "-",
    },
    float = {
      -- border = border,
      source = "if_many",
      focusable = false,
    },
    signs = true,
    severity_sort = true,
    update_in_insert = false,
  })

  -- virtual text icons
  local signs = { Error = "X ", Warn = "! ", Hint = "? ", Info = "i " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  -- vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
  -- vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
  -- vim.fn.sign_define("DiagnosticSignInformation", { text = "i", texthl = "DiagnosticSignInfo" })
  -- vim.fn.sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticSignHint" })

  M.on_attach = function(client, bufnr)
    -- setup keymaps
    require("plugins.lsp.keymap").setup(client, bufnr)
    -- deferred diagnostics
    require("dd").setup({
      timeout = 250,
    })
    if client.supports_method('textDocument/documentSymbol') then
      navic.attach(client, bufnr) -- attach navbar context compoment
    end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = nil })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = nil })
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
      virtual_text = false,
    })

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.

    -- cursor symbol hl
    require("illuminate").on_attach(client)
    vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
    vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
    vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
    -- Show line diagnostics on hover
    -- vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
    vim.api.nvim_exec([[ autocmd CursorHold * lua vim.diagnostic.open_float({border="none", focusable=false}) ]], false)

    -- highlight cursor symbol
    -- if client.resolved_capabilities.document_highlight then
    --   vim.cmd [[
    --     hi! LspReferenceRead ctermbg=gray guibg=gray
    --     hi! LspReferenceText ctermbg=gray guibg=gray
    --     hi! LspReferenceWrite ctermbg=gray guibg=gray
    --     augroup lsp_document_highlight
    --       autocmd! * <buffer>
    --       autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --       autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --     augroup END
    --   ]]
    -- end
    require("lsp_signature").on_attach()
  end

  --  set up installed servers
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" }
  })

  -- sumneko
  local lua_opts = M.get_config()
  local sumneko = require("plugins.lsp.sumneko")
  lua_opts.settings = sumneko.lua_settings
  lspconfig.lua_ls.setup(lua_opts)

  -- clangd
  local clangd_opts = M.get_config()
  clangd_opts.cmd = {
    "clangd",
    "--background-index",
    "-j=12",
    "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--clang-tidy-checks=*",
    "--all-scopes-completion",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--pch-storage=memory",
  }
  require("clangd_extensions").setup({
    server = clangd_opts,
    extensions = {
      autoSetHints = true, -- Automatically set inlay hints (type hints)
      hover_with_actions = true, -- Whether to show hover actions inside the hover window
      inlay_hints = { -- These apply to the default ClangdSetInlayHints command
        only_current_line = true,
        only_current_line_autocmd = "CursorHold", -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" note
        show_parameter_hints = true,
        show_variable_name = false,
        parameter_hints_prefix = "params: ",
        other_hints_prefix = "-> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
    },
  })

  -- rust analyzer
  local rust_opts = require("plugins.lsp.rusttools").opts
  local opts = M.get_config()
  rust_opts.server = vim.tbl_deep_extend("force", {}, {
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
    flags = opts.flags,
    handlers = opts.handlers,
  }, rust_opts.server or {})
  require("rust-tools").setup(rust_opts)

  -- vimls
  lspconfig.vimls.setup(M.get_config())

  -- toml
  -- lspconfig.taplo.setup(M.get_config())

  -- wgsl
  vim.cmd [[au BufRead,BufNewFile *.wgsl	set filetype=wgsl]]
  lspconfig.wgsl_analyzer.setup(M.get_config())

  -- python pyright
  lspconfig.pyright.setup(M.get_config())

  -- gopls
  lspconfig.gopls.setup(M.get_config())

  -- gopls
  lspconfig.sqlls.setup(M.get_config())

  -- typescript
  lspconfig.tsserver.setup(M.get_config())

  -- typescript
  lspconfig.volar.setup(M.get_config())
  
  -- emmet
  lspconfig.emmet_language_server.setup(M.get_config())

  -- java
  -- lspconfig.jdtls.setup(M.get_config())

  -- start null ls
  require("plugins.nullls").setup(M.get_config()) -- TODO: remove deprecated
  
  require("ufo").setup()
end

return M
