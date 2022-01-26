-- download packer & bootstrap packages if it isn't installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Auto compile when there are changes in plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.init({
	display = {
		title = "Packer",
		done_sym = "",
		error_syn = "×",
		keybindings = { toggle_info = "o" }
	}
})

return packer.startup({ function(use)
  -- TODO: Install
  -- https://github.com/sindrets/diffview.nvim better diff functionality
  -- https://github.com/glacambre/firenvim
  use 'lewis6991/impatient.nvim'
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'sainnhe/gruvbox-material'
  use 'norcalli/nvim-colorizer.lua'
  use 'ggandor/lightspeed.nvim'
  use 'chaoren/vim-wordmotion'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'christoomey/vim-tmux-navigator'
  use 'famiu/bufdelete.nvim'
  use 'antoinemadec/FixCursorHold.nvim' -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use 'junegunn/vim-easy-align'
  use 'kyazdani42/nvim-web-devicons'
  use 'ActivityWatch/aw-watcher-vim'
  use 'nathom/filetype.nvim'
  use 'airblade/vim-rooter'
  use 'mbbill/undotree'
  use 'editorconfig/editorconfig-vim'
  -- use 'rcarriga/nvim-notify' -- TODO: config file

  use { -- lsp config
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'mfussenegger/nvim-jdtls',
      'https://gitlab.com/yorickpeterse/nvim-dd.git',
      -- 'weilbith/nvim-code-action-menu',
    },
    config = function()
      require'settings.lsp.lspconfig'
    end,
  }

  use { -- treesitter
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    run = ':TSUpdate',
    config = function()
      require'settings.treesitter'
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

  -- use { -- Rust Tools
  --   'simrat39/rust-tools.nvim',
  --   config = function()
  --     require'settings.lsp.rust-tools'
  --   end
  -- }

  use { -- telescope
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = { "tami5/sqlite.lua" } } ,
    },
    config = function()
      require'settings.tscope'
    end,
  }

  use { -- lspkind
    'onsails/lspkind-nvim',
    config = function()
      require'settings.lsp.lspkind'
    end,
  }

  use { -- nvim-cmp
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-cmdline',
      'Furkanzmc/sekme.nvim',
      'andersevenrud/cmp-tmux',
    },
    config = function()
      require'settings.lsp.cmp'
    end,
  }

  use { -- autopairs
    'windwp/nvim-autopairs',
    config = function()
      require'settings.autopairs'
    end,
  }

  use { -- FTerm
    'numtostr/FTerm.nvim',
    config = function()
      local fterm = require('FTerm')
      fterm.setup({
        cmd = "export IS_FTERM=1 && " .. os.getenv('SHELL'),
        dimensions = {
          height = 0.75,
          width = 0.65,
          x = 0.5,
          y = 0.5,
        },
        border = 'single',
      })
      end,
    }

 use { -- Feline
  'famiu/feline.nvim',
  config = function()
    require'settings.feline'
  end,
 }

  use { -- Trouble
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'settings.trouble'
    end
  }

  use { -- better escape
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 200
      vim.g.better_escape_shortcut = { 'jk','kj' }
    end,
  }

  use { -- bufferline
    'akinsho/bufferline.nvim',
    requires = 'kyazdani43/nvim-web-devicons',
    config = function()
      require'settings.bufferline'
    end,
  }

  use { -- nvim tree
    'kyazdani42/nvim-tree.lua',
    config = function()
      require'settings.nvimtree'
    end,
  }

  use { -- gitsigns
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufEnter', -- this makes the plugin work for some reason?
    after = 'plenary.nvim',
    config = function()
      require'settings.gitsigns'
    end,
  }

  use { -- DAP
    'mfussenegger/nvim-dap',
    requires = {
      'nvim-telescope/telescope-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'Pocco81/DAPInstall.nvim',
    },
    config = function()
      require'settings.lsp.dap'
    end
  }

  use { -- AutoSaves the buffer
    'Pocco81/AutoSave.nvim',
    config = function()
      require'settings.autosave'
    end,
  }

  use { -- tpopes commentary with extras such as gcA and gcO
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use { -- neogit, magit for neovim
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup {}
    end,
  }

  use { -- zenmode
    'Pocco81/TrueZen.nvim',
    config = function()
      require'settings.truezen'
    end
  }

  use { -- alpha startup screen; startify & dashboard but developed
    'goolord/alpha-nvim',
    requires = 'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled
      })
      require'settings.alpha'
    end
  }

  -- use {  -- sniprun
  --   'michaelb/sniprun',
  --   run = 'bash ./install.sh',
  --   config = function()
  --     require'settings.sniprun'
  --   end
  -- }
  --
  use { -- blankline indent indicator
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        buftype_exclude = { "terminal" },
        filetype_exclude = { "alpha" },
        show_current_context_start = false,
        show_current_context = true,
      }
    end
  }
  use { -- which key
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup {
        }
    end
  }
  use { -- zettlekasten
    'mickael-menu/zk-nvim',
    config = function()
      require('settings.zk')
    end
  }

  use { -- lsp status
    'j-hui/fidget.nvim',
    config = function()
      require"fidget".setup{}
    end
  }

  use { -- keep windows in position
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup({
        ignore = {  -- do not manage windows matching these file/buftypes
          filetype = { "list", "help" },
          buftype = { "terminal" },
        },
      });
    end
  }

  if packer_bootstrap then -- auto set up conf after cloning packer.nvim
    require('packer').sync()
  end
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
  git = {
    clone_timeout = 120,
  },
  compile_path = vim.fn.stdpath('config')..'/lua/compiled/packer_compiled.lua'
}})
