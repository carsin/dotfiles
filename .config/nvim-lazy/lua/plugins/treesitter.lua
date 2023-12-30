return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    }
    opts.endwise = {
      enable = true,
    }
  end,
  dependencies = {
    "hiphish/rainbow-delimiters.nvim",
    "RRethy/nvim-treesitter-endwise",
  },
}
