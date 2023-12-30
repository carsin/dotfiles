return {
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup()
    end,
    keys = {
      {
        "<leader>cc",
        "<Cmd>CccPick<CR>",
        desc = "Color picker",
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
