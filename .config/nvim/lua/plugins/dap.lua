local dap = require('dap')
require('telescope').load_extension('dap')

vim.g.dap_virtual_text = true

-- LLDB: C, C++, Rust
dap.adapters.lldb = {
  type = 'executable',
  attach = { pidProperty = "pid", pidSelect = "ask" },
  command = '/usr/local/opt/llvm@12/bin/lldb-vscode',
  name = "lldb",
  env = function()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end,
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- TODO: Move to mappings.vim
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
map('n', '<leader>dh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
map('v', '<leader>dh', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
map('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

-- telescope-dap
map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-- nvim-dap-ui
map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>')

