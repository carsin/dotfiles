-- remove heavy unneeded sources from markdown
local cmp = require('cmp')
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
  local c = sources[i].name
  if c == 'buffer' or c == 'tmux' or c == 'luasnip' or c == 'path' then
    table.remove(sources, i)
  end
end
cmp.setup.buffer({ sources = sources })