require('lint').linters_by_ft = {
  markdown = {'vale', 'languagetool' },
},

-- vim.api.nvim_exec([[ au BufWritePost <buffer> if &ft!~?'markdown'|lua require('lint').try_lint() ]], false)
vim.api.nvim_exec([[ au BufWritePost <buffer> lua require('lint').try_lint() ]], false)
