local telescope = require('telescope')
local actions = require 'telescope.actions'

telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension('vimwiki')

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
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden" }
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=always',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    -- selection_strategy = "reset",
    -- sorting_strategy = "descending",
    -- layout_strategy = "horizontal",
    -- layout_config = {
    --   horizontal = {
    --     mirror = false,
    --   },
    --   vertical = {
    --     mirror = false,
    --   },
    -- },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = { ".git", "node_modules", "target", ".class" },
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
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

