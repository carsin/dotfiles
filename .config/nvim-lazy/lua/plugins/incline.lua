return { -- floating filename statuslines
  "b0o/incline.nvim",
  event = "BufReadPre",
  config = function()
    require("incline").setup({
      window = {
        margin = {
          vertical = 0,
          horizontal = 1,
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        return {
          { icon, guifg = color },
          { " " },
          { filename },
        }
      end,
    })
  end,
}
