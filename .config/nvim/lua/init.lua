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
  use 'dylanaraps/wal.vim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
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
  use { -- better escape
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 150
      vim.g.better_escape_shortcut = { 'jk' }
    end,
  }
  use { --lsp config
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.lspconfig"
    end,
  }
  use { -- vsnip snippets
    'hrsh7th/vim-vsnip',
    event = "InsertEnter"
  }
  use { -- friendly snippets
    'rafamadriz/friendly-snippets',
    event = "InsertEnter"
  }
  use { -- compe
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    requires = { { "" } },
    config = function()
      require "plugins.compe"
    end,
  }
  use { -- treesitter
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = ":TSUpdate",
    config = function()
      require "plugins.treesitter"
    end,
  }
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'
  use { -- gitsigns
    'lewis6991/gitsigns.nvim',
    confug = function()
      require "plugins.gitsigns"
    end,
  }
  -- use { -- lualine
  --   'hoob3rt/lualine.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true},
  --   config = function()
  --     require'lualine'.setup {
  --       options = {
  --         icons_enabled = false,
  --         theme = 'gruvbox',
  --         component_separators = {'│', '│'},
  --         section_separators = {'▓░', '░▓'},
  --       },
  --   }
  --   end,
  -- }
  use { -- lspkind
    'onsails/lspkind-nvim',
    config = function()
      require "plugins.lspkind"
    end,
  }
  use { -- lsp signature
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup()
    end,
  }
  use { -- telescope
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require "plugins.telescope"
    end,
  }
  use { -- rust tools
    'simrat39/rust-tools.nvim',
    config = function()
      require "plugins.rust-tools"
    end,
  }
  use { -- matchup
    "andymass/vim-matchup",
    event = "CursorMoved",
  }
  use { -- FTerm
    "numtostr/FTerm.nvim",
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
  use 'm-pilia/vim-ccls'
  use { -- Feline
    "famiu/feline.nvim",
    config = function()
      require "plugins.feline"
    end,
  }
  use { -- Trouble
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.trouble"
    end
  }
end)
