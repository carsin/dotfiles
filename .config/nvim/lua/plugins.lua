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

return packer.startup({function(use)
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
  use 'vimwiki/vimwiki'
  use { 'kyazdani42/nvim-web-devicons', event = 'BufEnter' }

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
    requires = { { 'nvim-treesitter/nvim-treesitter-textobjects' } },
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
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
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
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-cmdline',
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
        max_lines = 1000;
        sort = true;
        max_num_results = 20;
        run_on_every_keystroke = false;
        snippet_placeholder = 'gdfgsfggsdfg';
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

  use { -- Trouble
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'plugins.trouble'
    end
  }

  use { -- better escape
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.better_escape_interval = 250
      vim.g.better_escape_shortcut = { 'jk' }
    end,
  }

  use { -- bufferline
    'akinsho/bufferline.nvim',
    after = 'nvim-web-devicons',
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
    event = 'BufEnter',
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

  use { -- AutoSave
    'Pocco81/AutoSave.nvim',
    config = function()
      require'plugins.autosave'
    end,
  }

  use { -- comment
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- use { -- stabilize
  --   "luukvbaal/stabilize.nvim",
  --   config = function()
  --     require("stabilize").setup()
  --   end
  -- }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
