return {
  {
    "sainnhe/gruvbox-material", -- the colorscheme should be available when starting Neovim
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_show_eob = 1
      vim.g.gruvbox_material_visual = "reverse"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_palette = "original"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd([[colorscheme gruvbox-material]])

      require("notify").setup({
        background_colour = "#000",
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}
