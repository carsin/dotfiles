return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#585858",
          highlight = "CursorColumn",
        },
        marks = {
          GitAdd = { text = "│" },
          GitChange = { text = "│" },
          GitDelete = { text = "│" },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = false,
          ale = false,
        },
      })
    end,
  },
}
