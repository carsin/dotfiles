-- unneded
-- local border = {
-- 	{ "╭", "FloatBorder" },
-- 	{ "─", "FloatBouder" },
-- 	{ "╮", "FloatBorder" },
-- 	{ "│", "FloatBorder" },
-- 	{ "╯", "FloatBorder" },
-- 	{ "─", "FloatBorder" },
-- 	{ "╰", "FloatBorder" },
-- 	{ "│", "FloatBorder" },
-- }
-- local lsp = require("vim.lsp")
local sumneko = require("settings.lsp.sumneko")
local lsp_installer = require("nvim-lsp-installer")
local M = {}
vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "i", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "?", texthl = "DiagnosticSignHint" })

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
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

M.on_attach = function(client, bufnr)
	-- status.on_attach(client)
	require("dd").setup({
		timeout = 250,
	})
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = nil })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = nil })
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		update_in_insert = false,
		virtual_text = true,
	})
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc") -- Enable completion triggered by <c-x><c-o>
	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<c-space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("i", "<c-space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gh", '<cmd>lua require "telescope.builtin".lsp_code_actions()<CR>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>zz", opts)
	buf_set_keymap("n", "<leader>a", "<Cmd>Telescope lsp_code_actions theme=cursor<CR>", opts)
	buf_set_keymap("v", "<leader>a", "<Cmd>Telescope lsp_range_code_actions theme=cursor<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	-- TODO: Replace with neoformat
	buf_set_keymap("n", "gq", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("v", "gq", "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

	-- set mappings for zk if in wikidir
	require("settings.zk").set_mappings()
	-- cursor symbol hl
	require("illuminate").on_attach(client)
	-- Show line diagnostics on hover
	vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
	-- vim.api.nvim_exec([[ autocmd CursorHold * lua
	-- vim.diagnostic.open_float({border="none", focusable=false}) ]], false)
	-- vim.cmd [[autocmd FileType markdown nmap gz <buffer> :g/./ normal gqq<CR>]]

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
end

M.get_config = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	require("cmp_nvim_lsp").update_capabilities(capabilities)
	capabilities.workspace.configuration = true
	capabilities.textDocument.completion.completionItem.snippetSupport = true
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
		["clangd"] = function()
			opts = M.get_config()
			opts.cmd = {
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
		end,
	}

	if server.name == "rust_analyzer" then -- override rust_analyzer set up with rust-tools' implement
		local rust_opts = require("settings.lsp.rust-tools").opts
		rust_opts.server = vim.tbl_deep_extend("force", server:get_default_options(), {
			on_attach = opts.on_attach,
			capabilities = opts.capaibilities,
			flags = opts.flags,
			handlers = opts.handlers,
		})
		rust_opts.server.settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					allFeatures = true,
					overrideCommand = {
						"cargo",
						"clippy",
						"--workspace",
						"--all-targets",
						"--all-features",
						"--message-format=json",
					},
				},
			},
		}
		require("rust-tools").setup(rust_opts)
	elseif server.name == "jdtls" then -- override jdtls
		-- local jdtls_opts = require'plugins.lsp.jdtls'.config
		-- require("jdtls").start_or_attach(jdtls_opts)
	elseif server.name == "clangd" then -- use clangd extensions
		local c_opts = vim.tbl_deep_extend("force", server:get_default_options(), {
			on_attach = opts.on_attach,
			capabilities = opts.capaibilities,
			flags = opts.flags,
			handlers = opts.handlers,
      cmd = {
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
		})
		require("clangd_extensions").setup({
			server = c_opts,
			extensions = {
				autoSetHints = true, -- Automatically set inlay hints (type hints)
				-- Whether to show hover actions inside the hover window
				-- This overrides the default hover handler
				hover_with_actions = true,
				-- These apply to the default ClangdSetInlayHints command
				inlay_hints = {
					only_current_line = true,
					-- Event which triggers a refersh of the inlay hints.
					-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
					-- not that this may cause  higher CPU usage.
					-- This option is only respected when only_current_line and
					-- autoSetHints both are true.
					only_current_line_autocmd = "CursorHold,CursorHoldI",
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
		server:setup(c_opts)
	else
		-- check to see if any custom server_opts exist for the LSP server
		server:setup(server_opts[server.name] and server_opts[server.name]() or opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end
end)

return M
