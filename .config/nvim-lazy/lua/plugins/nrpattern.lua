return {
  { -- increment numbers & more with +/-
    "zegervdv/nrpattern.nvim",
    config = function()
      require("nrpattern").setup()
    end,
    keys = {
      {
        mode = { "n" },
        "+",
        "<Plug>(PatternIncrement)",
        { desc = "Increment Number" },
      },
      {
        mode = { "n" },
        "_",
        "<Plug>(PatternDecrement)",
        { desc = "Decrement Number" },
      },
      {
        mode = { "v" },
        "+",
        "<Plug>(PatternRangeIncrement)",
        { desc = "Increment Number Range" },
      },
      {
        mode = { "v" },
        "_",
        "<Plug>(PatternRangeDecrement)",
        { desc = "Decrement Number Range" },
      },
    },
  },
}
