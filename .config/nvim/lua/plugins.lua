if vim.fn.empty(vim.fn.stdpath('data') ..'/site/pack/packer/start/packer.nvim') > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', vim.fn.stdpath('data') ..'/site/pack/packer/start/packer.nvim' })
  vim.api.nvim_command 'packadd packer.nvim'
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

return packer.startup({ function(use)
  -- TODO: Install
  -- https://github.com/sindrets/diffview.nvim better diff functionality
  -- lewis6991/impatient.nvim speedup startup
  -- https://github.com/nvim-treesitter/nvim-treesitter-refactor better refactoring
  -- https://github.com/nathom/filetype.nvim replaces filetype.vim for faster loading
  -- mg979/vim-visual-multi multiple cursors
  -- https://github.com/lewis6991/spellsitter.nvim
  -- https://github.com/michaelb/sniprun <-- THIS IS AWESOME
    -- dep: https://github.com/rcarriga/nvim-notify
  -- https://github.com/glacambre/firenvim

  -- CHOOSE:
    -- neorg
    -- https://github.com/preservim/vim-pencil
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'sainnhe/gruvbox-material'
  use 'norcalli/nvim-colorizer.lua'
  use 'ggandor/lightspeed.nvim'
  use 'editorconfig/editorconfig-vim'
  use 'chaoren/vim-wordmotion'
  use 'tpope/vim-surround'
  use 'christoomey/vim-tmux-navigator'
  use 'famiu/bufdelete.nvim'
  use 'antoinemadec/FixCursorHold.nvim' -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use 'junegunn/vim-easy-align'
  use 'vimwiki/vimwiki' -- Replace? https://github.com/oberblastmeister/neuron.nvim
  use 'kyazdani42/nvim-web-devicons'

  -- TODO: Fix <CR> on startup
  -- use { -- alpha startup screen; startify & dashboard but developed
  --   'goolord/alpha-nvim',
  --   requires = 'Shatur/neovim-session-manager',
  --   config = function ()
  --       require'alpha'.setup(require'alpha.themes.dashboard'.opts)
  --   end
  -- }

  use { -- lsp config
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'mfussenegger/nvim-jdtls',
      'https://gitlab.com/yorickpeterse/nvim-dd.git',
      'weilbith/nvim-code-action-menu',
    },
    config = function()
      require'plugins.lsp.lspconfig'
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
      require'plugins.treesitter'
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

  use { -- Rust Tools
    'simrat39/rust-tools.nvim',
    config = function()
      require'plugins.lsp.rust-tools'
    end
  }

  -- use {
  --   'kosayoda/nvim-lightbulb',
  --   config = function()
  --     vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  --     -- vim.fn.sign_define('LightBulbSign', { text = "?", texthl = "", linehl="", numhl="" })
  --   end
  -- }

  use { -- telescope
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'ElPiloto/telescope-vimwiki.nvim',
      'nvim-telescope/telescope-project.nvim',
      'ElPiloto/telescope-vimwiki.nvim',
      'kyazdani42/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = { "tami5/sqlite.lua" } } ,
    },
    config = function()
      require'plugins.tscope'
    end,
  }

  use { -- lspkind
    'onsails/lspkind-nvim',
    config = function()
      require'plugins.lsp.lspkind'
    end,
  }


  use { -- nvim-cmp
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-calc',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-cmdline',
      'Furkanzmc/sekme.nvim',
      { 'andersevenrud/compe-tmux', branch = 'cmp' },
    },
    config = function()
      require'plugins.lsp.cmp'
    end,
  }

  use { -- tabnine
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp',
    after = "nvim-cmp",
    config = function()
      -- TODO: move to lsp/cmp.lua
      require('cmp_tabnine.config'):setup({
        max_lines = 1500;
        sort = true;
        max_num_results = 3;
        run_on_every_keystroke = false;
        snippet_placeholder = '..';
      })
    end
  }

  use { -- autopairs
    'windwp/nvim-autopairs',
    config = function()
      require'plugins.autopairs'
    end,
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
      require'plugins.feline'
    end,
  }

  -- TODO: Replace? https://github.com/kevinhwang91/nvim-bqf
  -- or https://github.com/stevearc/qf_helper.nvim
  use { -- Trouble
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'plugins.trouble'
    end
  }

  use { -- better escape
    'jdhao/better-escape.vim',
    -- event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 250
      vim.g.better_escape_shortcut = { 'jk' }
    end,
  }

  use { -- bufferline
    'akinsho/bufferline.nvim',
    requires = 'kyazdani43/nvim-web-devicons',
    config = function()
      require'plugins.bufferline'
    end,
  }

  use { -- nvim tree
    'kyazdani42/nvim-tree.lua',
    config = function()
      require'plugins.nvimtree'
    end,
  }

  use { -- gitsigns
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufEnter', -- this makes the plugin work for some reason?
    after = 'plenary.nvim',
    config = function()
      require'plugins.gitsigns'
    end,
  }

  -- use { -- DAP
  --   'mfussenegger/nvim-dap',
  --   requires = {
  --     'nvim-telescope/telescope-dap.nvim',
  --     'theHamsta/nvim-dap-virtual-text',
  --     'rcarriga/nvim-dap-ui',
  --   },
  --   config = function()
  --     require'plugins.lsp.dap'
  --   end
  -- }

  use { -- AutoSaves the buffer
    'Pocco81/AutoSave.nvim',
    config = function()
      require'plugins.autosave'
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

  use {
    'Pocco81/TrueZen.nvim',
    config = function()
      require'plugins.truezen'
    end
  }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})


