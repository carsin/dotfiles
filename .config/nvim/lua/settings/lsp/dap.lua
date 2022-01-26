local dap = require('dap')

vim.g.dap_virtual_text = true

-- CodeLLDB: C, C++, Rust
-- custom attach function
dap.adapters.codelldb = function(on_adapter)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  -- absolute path to bin
  local cmd = '/home/carson/.local/share/nvim/user_servers/codelldb/extension/adapter/codelldb'

  local handle, pid_or_err
  local opts = {
    stdio = {nil, stdout, stderr},
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      local port = chunk:match('Listening on port (%d+)')
      if port then
        vim.schedule(function()
          on_adapter({
            type = 'server',
            host = '127.0.0.1',
            port = port
          })
        end)
      else
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end
  end)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
end

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}

-- use it for c
dap.configurations.c = dap.configurations.cpp

-- dap.configurations.java = {
--   {
--     type = 'java';
--     request = 'attach';
--     name = "Debug (Attach) - Remote";
--     hostName = "127.0.0.1";
--     port = 5005;
--   },
-- }
local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

-- Keymaps
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
map('n', '<leader>m', '<cmd>lua require"dapui".toggle()<CR>')
