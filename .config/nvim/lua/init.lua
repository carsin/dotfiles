-- Install packer if it isnt already
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost init.lua PackerCompile'

local packer = require('packer')
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'tpope/vim-commentary'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'cohama/lexima.vim'
  use 'sainnhe/gruvbox-material'
  use 'norcalli/nvim-colorizer.lua'
  use 'editorconfig/editorconfig-vim'
  use 'airblade/vim-rooter'
  use 'ggandor/lightspeed.nvim'
  use 'mhinz/vim-startify'
  use 'chaoren/vim-wordmotion'
  use 'tpope/vim-surround'
  use 'tpope/vim-speeddating'

  use { -- better escape
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 150
      vim.g.better_escape_shortcut = { 'jk' }
    end,
  }

  use { --lsp config
    'neovim/nvim-lspconfig',
    config = function()
      require 'plugins.lspconfig'
    end,
  }

  use { -- treesitter
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.treesitter'
    end,
  }

  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { 'ms-jpq/coq_nvim', branch = 'coq'} -- main one
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets

  use { -- lsp signature
    'ray-x/lsp_signature.nvim',
    config = function()
      require 'lsp_signature'.setup()
    end,
  }

  use { -- telescope
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require 'plugins.telescope'
    end,
  }

  use { -- matchup
    'andymass/vim-matchup',
    event = 'CursorMoved',
  }

  use { -- FTerm
    'numtostr/FTerm.nvim',
    config = function()
      require'FTerm'.setup({
        dimensions = {
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5
        },
        border = 'single' -- or 'double'
      })
    end,
  }

  use {
    'm-pilia/vim-ccls',
    after = "nvim-lspconfig"
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

  use { -- gitsigns
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('gitsigns').setup {
        keymaps = {
          noremap = false,
        }
      }
    end,
  }

  use { -- numb
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  }

  use { -- project
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        silent_chdir = true,
        show_hidden = true,
        ignore_lsp = { "sumneko_lua" },
        exclude_dirs = { "~/.config/nvim/lua" }
      }
    end
  }
end)
