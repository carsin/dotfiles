-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local nvim_tmux_nav = require("nvim-tmux-navigation")

vim.keymap.set("n", "<silent><ESC>", ":nohlsearch \\| :cclose<CR>") -- Multifunctional escape! (close popup windows & clear search hl)
-- Dont put change operations into register
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
-- Window splits
vim.keymap.set("n", "<C-v>", "<Cmd>vsplit<CR>")
vim.keymap.set("n", "<C-b>", "<Cmd>split<CR>")
vim.keymap.set("n", "<C-c>", "<Cmd>close<CR>")

-- Switch to previous buffer
vim.keymap.set("n", "<Backspace>", "<C-^>")

-- File navigation
vim.keymap.set(
  "n",
  "<leader>E",
  '<Cmd>lua require("neo-tree.command").execute({ position="left", toggle = true, dir = require("lazyvim.util").root() }) <CR>'
)

-- toggle lsp lines for line diagnostics
vim.keymap.set("n", "<Leader>cd", require("lsp_lines").toggle, { desc = "Toggle line diagnostics" })

-- replacement
vim.keymap.set("n", "<Leader>R", ":%s//g<Left><Left>", { desc = "Replace in file" })
vim.keymap.set("v", "<Leader>R", ":s//g<Left><Left> ", { desc = "Replace in file (visual)" })

-- tmux/split navigation
vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)

-- fast quitting
vim.cmd([[cnoreabbrev qq qa!]])
vim.cmd([[cnoreabbrev qA qa!]])
vim.cmd([[cnoreabbrev Qa qa!]])
vim.cmd([[cnoreabbrev QA qa!]])
vim.cmd([[cnoreabbrev wqq wqa!]])
