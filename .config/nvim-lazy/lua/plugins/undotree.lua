return {
  "mbbill/undotree",
  lazy = true,
  keys = {
    { "<leader>cu", ":UndotreeToggle<CR>", desc = "Open Undo Tree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
