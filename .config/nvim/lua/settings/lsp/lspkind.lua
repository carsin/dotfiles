local M = {}
M.icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  -- Variable = "",
	Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  -- Reference = "",
	Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  -- Struct = "",
	Struct = "פּ",
  -- Event = "",
	Event = "",
  Operator = "",
  TypeParameter = ""
}
  
-- defaults: for reference
-- M.symbol_map = {
-- 	Text = "",
-- 	Method = "",
-- 	Function = "",
-- 	Constructor = "",
-- 	Field = "ﰠ",
-- 	Class = "ﴯ",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "ﰠ",
-- 	Unit = "塞",
-- 	Value = "",
-- 	Enum = "",
-- 	Keyword = "",
-- 	Snippet = "",
-- 	Color = "",
-- 	File = "",
-- 	Folder = "",
-- 	EnumMember = "",
-- 	Constant = "",
-- 	Operator = "",
-- 	TypeParameter = "",
-- }
--
require("lspkind").init({
		mode = "symbol_text",
		symbol_map = M.icons,
})

return M
