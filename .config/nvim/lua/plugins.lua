-- Install packer if it isnt already
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

local packer = require('packer')

packer.init({
	display = {
		title = "Packer",
		done_sym = "",
		error_syn = "×",
		keybindings = { toggle_info = "o" }
	}
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'sainnhe/gruvbox-material'
  use 'norcalli/nvim-colorizer.lua'
  use 'editorconfig/editorconfig-vim'
  use 'ggandor/lightspeed.nvim'
  use 'mhinz/vim-startify'
  use 'chaoren/vim-wordmotion'
  use 'tpope/vim-surround'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-commentary'
  use 'christoomey/vim-tmux-navigator'
  use 'famiu/bufdelete.nvim'
  use 'antoinemadec/FixCursorHold.nvim' -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use 'junegunn/vim-easy-align'

  use { -- better escape
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 150
      vim.g.better_escape_shortcut = { 'jk' }
    end,
  }

  use { -- lsp config
    'neovim/nvim-lspconfig',
    config = function()
      require 'plugins.lspconfig'
    end,
  }

  use { -- treesitter
    'nvim-treesitter/nvim-treesitter',
    requires = { { 'nvim-treesitter/nvim-treesitter-textobjects' } },
    run = ':TSUpdate',
    config = function()
      require 'plugins.treesitter'
    end,
  }

  use { -- lsp signature
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup({
        floating_window_above_cur_line = true,
        hint_prefix = '? ',
      })
    end,
  }

  use { -- telescope
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require 'plugins.telescope'
    end,
  }

  use { -- matchup
    'andymass/vim-matchup',
    event = 'CursorMoved',
  }

  use { -- lspkind
    'onsails/lspkind-nvim',
    config = function()
      require 'plugins.lspkind'
    end,
  }

  use { -- nvim-cmp
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'f3fora/cmp-spell',
      'rafamadriz/friendly-snippets',
      { 'andersevenrud/compe-tmux', branch = 'cmp' },
    },
    config = function()
      require 'plugins.cmp'
    end,
  }

  use { -- autopairs
    'windwp/nvim-autopairs',
    config = function()
      require 'plugins.autopairs'
    end,
  }

  use { -- ccls
    'm-pilia/vim-ccls',
    after = "nvim-lspconfig"
  }

  use { -- FTerm
    'numtostr/FTerm.nvim',
    config = function()
      local fterm = require('FTerm')
      fterm.setup({
        dimensions = {
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5,
        },
        border = 'single'
      })
      end,
    }

  use { -- Feline
    'famiu/feline.nvim',
    config = function()
      require 'plugins.feline'
    end,
  }

  use { -- Trouble
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.trouble'
    end
  }

  use { -- project
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        silent_chdir = true,
        show_hidden = true,
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "init.vim" },
        ignore_lsp = { "sumneko_lua" },
        exclude_dirs = { "~/.config/nvim/lua", "~/.config/nvim/lua/plugins", ".git/" },
      }
    end
  }

  use { -- bufferline
    'akinsho/bufferline.nvim',
    requires = 'kyazdani43/nvim-web-devicons',
    config = function()
      require 'plugins.bufferline'
    end,
  }

  use { -- nvim tree
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.nvimtree'
    end,
  }

  use { -- gitsigns
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufEnter',
    config = function()
      require 'plugins.gitsigns'
    end,
  }
end)
