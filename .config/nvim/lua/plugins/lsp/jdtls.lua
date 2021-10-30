local jdtls = require 'jdtls'
local home = os.getenv('HOME')
local jdtls_executable = home .. "/.config/nvim/bin/jdtls.sh"
local root_markers = {'gradlew', '.git', '.classpath', 'run'  }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local M = {}

-- Configure JDTLS
M.config = require("plugins.lsp.lspconfig").get_config()
M.config.cmd = { jdtls_executable, workspace_folder }
M.config.flags.server_side_fuzzy_completion = true
M.config.settings = {
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
M.config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}

M.config.handlers['language/status'] = function() end -- mute startup output; having progress reports is enough

-- TODO: Add DAP
-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
-- you make during a debug session immediately.
-- Remove the option if you do not want that.
-- require('jdtls').setup_dap({ hotcodereplace = 'auto' })

return M;
