-- Java specific keybinds
vim.api.nvim_set_keymap("n", "<leader>a", ":lua require('jdtls').code_action()<CR>", { noremap = true, silent = true })

-- Commands
vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

-- attach server if not already
require("jdtls").start_or_attach(require'plugins.lsp.jdtls'.config)
