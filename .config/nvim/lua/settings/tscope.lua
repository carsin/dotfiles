local telescope = require('telescope')
local actions = require 'telescope.actions'
local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local M = {};

-- Don't show previews for binaries
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
        end)
      end
    end
  }):sync()
end

M.custom_dropdown = require('telescope.themes').get_dropdown({
  layout_config = {
    width = 80;
  }
});

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    project = {
      hidden_files = true,
    },
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      disable_devicons = false,
      workspaces = {
        ["conf"]    = "~/.config",
        ["wiki"]    = "~/files/wiki/"
      }
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden" }
    },
    -- lsp_references = custom_down;
    lsp_references = {
      theme = "ivy" -- i like this enough for now
    },
    lsp_definitions = {
      theme = "ivy"
    },
    lsp_implementations = {
      theme = "ivy"
    },
  },
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.6,
        width = 0.9,
        height = 0.8,
        mirror = false,
      },
      vertical = {
        width = 0.9,
        height = 0.9,
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { ".git", "node_modules", "target", ".class", ".cache", ".png" },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    buffer_previewer_maker = new_maker,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-q>"] = actions.close,
        ["J"] = actions.move_selection_next,
        ["K"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      -- n = {},
    }
  },
}

telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension('vimwiki')
telescope.load_extension('frecency')
telescope.load_extension('sessions')
return M;
