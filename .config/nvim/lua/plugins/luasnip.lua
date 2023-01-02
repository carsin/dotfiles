local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  }
}
M.config = function()
  -- local present, luasnip = pcall(require, "luasnip")
  -- if not present then
  --   return
  -- end
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
    -- ext_ops = {
    --   [types.choiceNode] = {
    --     active = {
    --       virt_text = { { "<-", "Error" } },
    --     }
    --   }
    -- }
  })

  require("luasnip.loaders.from_vscode").lazy_load()
end

return M;
