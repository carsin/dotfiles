local jdtls = require 'jdtls'
local home = os.getenv('HOME')
local jdtls_executable = home .. "/.local/share/nvim/lspinstall/java/jdtls.sh"
local root_markers = {'gradlew', '.git', '.classpath', 'run'  }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Configure JDTLS
local config = require("plugins.lsp.lspconfig").get_config()
config.cmd = { jdtls_executable, workspace_folder, ":p:h:t" }
config.flags.server_side_fuzzy_completion = true
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     update_in_insert = true,
--     virtual_text = true,
--   }
-- )
config.settings = {
  java = {
    -- signatureHelp = { enabled = true };
    contentProvider = { preferred = 'fernflower' };
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*"
      }
    };
    sources = {
      organizeImports = {
        starThreshold = 9999;
        staticStarThreshold = 9999;
      };
    };
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      }
    };
  };
}

local jar_patterns = {
  home .. '/.local/share/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
  home .. '/.local/share/dgileadi/vscode-java-decompiler/server/*.jar',
  home .. '/.local/share/microsoft/vscode-java-test/server/*.jar',
}

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
-- vim.list_extend(bundles, vim.fn.glob('~/.local/share/java_debug/com.microsoft.java.debug.plugin-0.33.0.jar'))
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/microsoft/vscode-java-test/server/*.jar"), "\n"))
config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}

-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
-- you make during a debug session immediately.
-- Remove the option if you do not want that.
require('jdtls').setup_dap({ hotcodereplace = 'auto' })

-- Start jdtls
require("jdtls").start_or_attach(config)

-- Java specific keybinds
vim.api.nvim_set_keymap("n", "<leader>la", ":lua require('jdtls').code_action()<CR>", { noremap = true, silent = true })

vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
