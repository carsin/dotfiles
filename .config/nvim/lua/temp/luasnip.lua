local present, luasnip = pcall(require, "luasnip")
if not present then
	return
end

luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
  ext_ops = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" }},
      }
    }
  }
})

require("luasnip.loaders.from_vscode").lazy_load()
