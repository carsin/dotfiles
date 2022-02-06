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
