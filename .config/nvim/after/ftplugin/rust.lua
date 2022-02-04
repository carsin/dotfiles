vim.api.nvim_set_keymap("n", "<leader>cr", ":lua require('rust-tools.runnables').runnables()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cc", ":lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>a", ":lua require('rust-tools.hover_actions').hover_actions()<CR>", { noremap = true, silent = true })
