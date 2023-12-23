local wk = require("which-key")

local M = {}

function M.setup(client, buffer)
  local cap = client.server_capabilities
  local keymap = {
    buffer = buffer,
    ["<leader>"] = {
      c = {
        name = "+code",
        r = {
          function()
            require("inc_rename")
            return ":IncRename " .. vim.fn.expand("<cword>")
          end,
          "Rename",
          cond = cap.renameProvider,
          expr = true,
        },
        a = {
          { vim.lsp.buf.code_action, "Code Action" },
          { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
        },
        f = {
          {
           "<Cmd>lua vim.lsp.buf.format { async=true }<CR>",
            "Format Document",
            -- require("plugins.lsp.formatting").format,
            -- cond = cap.documentFormatting,
          },
          {
            "<Esc><Cmd>lua vim.lsp.buf.range_formatting()<CR>",
            "Format Range",
            cond = cap.documentRangeFormatting,
            mode = "v",
          },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        l = {
          name = "+lsp",
          i = { "<cmd>LspInfo<cr>", "Lsp Info" },
          a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
          r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
          l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" },
        },
      },
      x = {
        d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      },
    },
    g = {
      name = "+goto",
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
      r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
      i = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
      l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Diagnostic Float" },
    },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help", mode = { "n", "i" } },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Next Diagnostic" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Prev Diagnostic" },
    ["[e"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", "Next Error" },
    ["]e"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", "Prev Error" },
    ["[w"] = {
      "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Next Warning",
    },
    ["]w"] = {
      "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARNING})<CR>",
      "Prev Warning",
    },
  }

  wk.register(keymap)
end

return M
