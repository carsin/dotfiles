vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_width = 30
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.tree_git_hl = 1
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

require'nvim-tree'.setup {
  disable_netrw = true, -- disables netrw completely
  hijack_netrw = true,
  open_on_setup = false,
  tree_ignore = { ".git", "node_modules", "target" },
  ignore_ft_on_setup = { 'startify' }, -- will not open on setup if the filetype is in this list
  auto_close = true, -- closes neovim automatically when the tree is the last **WINDOW** in the view
  open_on_tab = false, -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  update_to_buf_dir = { -- hijacks new directory buffers when they are opened.
    enable = false,
    auto_open = true, -- allow to open the tree if it was previously closed
  },
  hijack_cursor = false, -- hijack the cursor in the tree to put it at the start of the filename
  update_cwd = true, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  diagnostics = { -- show lsp diagnostics in the signcolumn
    enable = true,
    icons = {
      hint = "?",
      info = "i",
      warning = "!",
      error = "E",
    }
  },
  update_focused_file = { -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    enable = true, -- enables the feature
    update_cwd = true,
    ignore_list = {},
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  },
}
