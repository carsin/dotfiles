local config = require("settings.lsp.lspconfig").get_config()
local null_ls = require('null-ls')
local builtins = null_ls.builtins

null_ls.setup({
	sources = {
    -- glob
    builtins.code_actions.refactoring,
    -- lua
		builtins.formatting.stylua,
    -- sh
		builtins.formatting.shfmt,
    builtins.diagnostics.shellcheck,
    -- builtins.code_actions.shellcheck, -- only actions to disable error
    -- markdown(prose)
		builtins.diagnostics.write_good,
		builtins.diagnostics.codespell.with({
      filetypes = { "markdown" }
    }),
		builtins.formatting.codespell.with({
      filetypes = { "markdown" }
    }),
  --   builtins.code_actions.proselint,
		-- builtins.diagnostics.proselint.with({ -- see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/443
		-- 	parseJson = {
		-- 		errorsRoot = "data.errors",
		-- 		line = "line",
		-- 		column = "column",
		-- 		message = "[proselint] ${message} (${check})",
		-- 		security = "severity",
		-- 	},
		-- 	securities = {
		-- 		error = "error",
		-- 		warning = "warning",
		-- 		info = "suggestion",
		-- 	},
		-- }),
	},
	on_attach = config.on_attach,
	debounce = config.flags.debounce_text_changes,
})
