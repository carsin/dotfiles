local telescope = require('telescope')
local actions = require 'telescope.actions'
local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local action_state = require('telescope.actions.state')
local custom_actions = {}
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

-- opening files found in telescope in splits/tabs
function custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())
    if num_selections > 1 then
        local picker = action_state.get_current_picker(prompt_bufnr)
        local cwd = picker.cwd
        vim.cmd("bw!") -- wipe the prompt buffer
        for _, entry in ipairs(picker:get_multi_selection()) do
            -- local path = vim.api.nvim_call_function( 'fnamemodify', {entry.value, ':p'})
            vim.cmd(string.format("%s %s/%s", open_cmd, cwd, entry.value))
        end
        vim.cmd('stopinsert')
    else
        if open_cmd == "vsplit" then
            actions.file_vsplit(prompt_bufnr)
        elseif open_cmd == "split" then
            actions.file_split(prompt_bufnr)
        elseif open_cmd == "tabe" then
            actions.file_tab(prompt_bufnr)
        else
            actions.file_edit(prompt_bufnr)
        end
    end
end
function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "edit")
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
      workspaces = {
        ["conf"]    = "~/.config",
        ["wiki"]    = "~/files/wiki/"
      }
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden" },
      mappings = {
        i = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        },
        n = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        }
      }
    },

    live_grep = {
      -- disable_devicons = true,
      mappings = {
        i = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        },
        n = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        }
      }
    },

    frecency = {
      mappings = {
        i = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        },
        n = {
          ["<CR>"] = custom_actions.multi_selection_open,
          ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
          ["<c-b>"] = custom_actions.multi_selection_open_split,
          ["<c-t>"] = custom_actions.multi_selection_open_tab,
        }
      }
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
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      -- '-i .git/',
      -- '-i .node_modules/',
      -- '-i .target/',
      '-U'
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
        -- ["J"] = actions.move_selection_next,
        -- ["K"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      },
      n = {
        ["<Esc>"] = actions.close,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      }
    }
  },
}

telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension('frecency')
telescope.load_extension('dap')
-- telescope.load_extension('sessions')
-- telescope.load_extension('notify')
return M;
