local M = {
  "numtostr/FTerm.nvim",
  keys = {
    { "<leader>t", "<CMD>call OpenTerm()<CR>", mode="n" },
    { mode = "n", "<C-t>", "<CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "t", "<C-t>", "<CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "t", "<C-g>", "<CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "n", "<F3>", "<CMD>w<CR><CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "i", "<F3>", "<CMD>w<CR><CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "t", "<F3>", "<CMD>lua require(\"FTerm\").toggle()<CR>" },
    { mode = "t", "<ESC>", "<CMD>lua require(\"FTerm\").close()<CR>" },
    -- { mode = "n", "<F2>", "<CMD>w<CR><CMD>lua require(\"FTerm\").scratch({cmd = './run'})<CR>" },
    -- { mode = "i", "<F2>", "<CMD>w<CR><CMD>lua require(\"FTerm\").scratch({cmd = './run'})<CR>" },
    { "<leader>oo", "<CMD>lua __fterm_ranger()<CR>" },
  }
}
M.config = function()
  local fterm = require("FTerm")

  local rangerui = fterm:new({
    cmd = "ranger",
    ft = 'FTerm',
    dimensions = {
      height = 0.6,
      width = 0.7,
      x = 0.5,
      y = 0.5,
    }
  })

  function _G.__fterm_ranger()
    rangerui:toggle()
  end

  fterm.setup({
    cmd = "export IS_FTERM=1 && " .. os.getenv("SHELL"),
    -- blend = 30, -- not useful
    ft = 'FTerm',
    dimensions = {
      height = 0.85,
      width = 0.80,
      x = 0.5,
      y = 0.5,
    },
    border = "single",
  })

end
return M;
