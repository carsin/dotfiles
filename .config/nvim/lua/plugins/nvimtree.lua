vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_width = 30
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_follow = 1 -- "0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_auto_ignore_ft = 'startify'
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_auto_resize = 0
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_ignore = { ".git", "node_modules", "target" }
vim.g.tree_git_hl = 1
vim.g.nvim_tree_follow = 1
-- vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = "*",
    staged = "+",
    unmerged = "",
    renamed = "->",
    untracked = "",
    deleted = "-",
    ignored = ""
  },
  folder = {
    arrow_open = "v",
    arrow_closed = ">",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
  lsp = {
    hint = "?",
    info = "i",
    warning = "!",
    error = "E",
  }
}
