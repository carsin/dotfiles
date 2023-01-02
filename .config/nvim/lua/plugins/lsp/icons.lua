local M = {};
M.icons = {
  File          = " ",
  Module        = " ",
  Namespace     = " ",
  Package       = " ",
  Class         = "ﴯ ",
  Method        = " ",
  Property      = "ﰠ ",
  Field         = " ",
  Constructor   = " ",
  Enum          = "練",
  Interface     = " ",
  Function      = " ",
  Variable      = " ",
  Constant      = " ",
  String        = " ",
  Number        = " ",
  Boolean       = "◩ ",
  Array         = " ",
  Object        = " ",
  Key           = " ",
  Keyword       = "",
  Null          = "ﳠ ",
  EnumMember    = " ",
  Struct        = "פּ ",
  Event         = " ",
  Operator      = " ",
  TypeParameter = " ",
  Text          = " ",
  Unit          = " ",
  Value         = " ",
  Reference     = " ",
  Folder        = " ",
  Snippet       = " ",
}

function M.cmp_format()
  return function(_entry, vim_item)
    if M.icons[vim_item.kind] then
      vim_item.kind = M.icons[vim_item.kind] .. vim_item.kind
      vim_item.abbr = string.sub(vim_item.abbr, 1, 17) -- limit width
    end
    return vim_item
  end
end

return M;
