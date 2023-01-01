return {
  "folke/which-key.nvim",
   "wbthomason/packer.nvim",
   "nvim-lua/popup.nvim",
   "nvim-lua/plenary.nvim",
   "sainnhe/gruvbox-material",
   "norcalli/nvim-colorizer.lua",
   "chaoren/vim-wordmotion", -- more intuitive w/W motion
   "wellle/targets.vim", -- more text objects to target
   "skywind3000/asyncrun.vim", -- asynchronously run tasks such as make
   "tpope/vim-surround",
   "tpope/vim-repeat",
   "tpope/vim-unimpaired", -- handy ][ mappings that should be builtin
   "editorconfig/editorconfig-vim",
   "christoomey/vim-tmux-navigator",
   "famiu/bufdelete.nvim",
   "antoinemadec/FixCursorHold.nvim", -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
   "kyazdani42/nvim-web-devicons",
   "mbbill/undotree",
   "ThePrimeagen/harpoon",
   {"stevearc/dressing.nvim", event = "VeryLazy"}, -- make default UI components look good
   "zhimsel/vim-stay", -- automated view session creation & restore for buffers, sesssions and windows
   "andymass/vim-matchup", -- extend %: highlight, navigate, and operate on sets of matching text
   "SmiteshP/nvim-navic", -- lsp code context winbar component
  { "folke/drop.nvim", event = "VimEnter", enabled = true, config = function() math.randomseed(os.time()) local theme = ({ "stars", "snow", "xmas" })[math.random(1, 3)] require("drop").setup({ theme = theme }) end, },
   -- { -- zettlekasten
   --   "mickael-menu/zk-nvim",
   --   config = function()
   --     -- require("plugins.zk")
   --   end,
   -- },
    -- { -- Rust Tools
    --   "simrat39/rust-tools.nvim",
    --   config = function()
    --     -- require("plugins.lsp.rust-tools")
    --   end,
    -- },
    { -- autopairs
      "windwp/nvim-autopairs",
      config = function()
        require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt", "vim", "markdown" }
        })
      end,
    },
    -- { -- FTerm
    --   "numtostr/FTerm.nvim",
    --   config = function()
    --     -- require("plugins.fterm")
    --   end,
    -- },
    -- { -- Trouble
    --   "folke/trouble.nvim",
    --   dependencies = "kyazdani42/nvim-web-devicons",
    --   config = function()
    --     -- require("plugins.trouble")
    --   end,
    -- },
    { -- better escape
      "jdhao/better-escape.vim",
      event = "InsertEnter",
      config = function()
        vim.g.better_escape_interval = 200
        vim.g.better_escape_shortcut = { "jk", "kj" }
      end,
    },
    -- { -- neo tree
    --   "nvim-neo-tree/neo-tree.nvim",
    --   branch = "v2.x",
    --   dependencies = {
    --     "nvim-lua/plenary.nvim",
    --     "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    --     "MunifTanjim/nui.nvim",
    --   },
    --   config = function()
    --     -- require("plugins.neotree")
    --   end,
    -- },
    -- { -- gitsigns
    --   "lewis6991/gitsigns.nvim",
    --   dependencies = "nvim-lua/plenary.nvim",
    --   event = "BufEnter", -- this makes the plugin work for some reason?
    --   config = function()
    --     -- require("plugins.gitsigns")
    --   end,
    -- },
    -- { -- AutoSaves the buffer
    --   "Pocco81/auto-save.nvim",
    --   config = function()
    --     -- require("plugins.autosave")
    --   end,
    -- },
    { -- tpopes commentary with extras such as gcA and gcO
      "numToStr/Comment.nvim",
      config = function()
        local U = require("Comment.utils")
        local F = require("Comment.ft")

        require("Comment").setup({
          pre_hook = function()
            local filetype = vim.bo.filetype
            -- Always use blockwise commentstring for `c`
            if filetype == "c" then
              return F.get(filetype, U.ctype.block)
            end
          end,
        })
      end,
    },
    { -- alpha startup screen; startify & dashboard but developed
      "goolord/alpha-nvim",
      dependencies = "Shatur/neovim-session-manager",
      config = function()
        local path = require("plenary.path")
        require("session_manager").setup({
          autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
          sessions_dir = path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
          autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
            "gitcommit",
            "terminal,",
          },
        })
        -- require("plugins.alpha")
      end,
    },
    { -- blankline indent indicator
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("indent_blankline").setup({
          buftype_exclude = { "terminal" },
          filetype_exclude = { "alpha" },
          show_current_context_start = false,
          show_current_context = true,
        })
      end,
    },
    { -- lsp status widget
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({
          text = {
            spinner = "dots_footsteps",
            done = "✓",
          },
          sources = {
            ["null-ls"] = {
              ignore = true,
            }
          },
          window = {
            blend = 10, -- &winblend for the window
          },
          align = {
            bottom = true, -- align fidgets along bottom edge of buffer
            right = true, -- align fidgets along right edge of buffer
          },
          timer = {
            task_decay = 2000, -- how long to keep around completed task, in ms
          },
          fmt = {
            max_width = 50,
          }
        })
      end,
    },
    { -- rooter
      "jedi2610/nvim-rooter.lua",
      config = function()
        require("nvim-rooter").setup({
          rooter_patterns = {
            ".git",
            "Makefile",
            "*.sln",
            ".classpath",
            "build/env.sh",
            "Cargo.toml",
            "init.vim",
          },
        })
      end,
    },
    { -- jetpack
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").opts.ignore_case = false
        require("lightspeed").opts.safe_labels = {}
      end,
    },
    { -- increment numbers & more with +/-
      "zegervdv/nrpattern.nvim",
      config = function()
        require("nrpattern").setup()
      end,
    },
    { -- incremental rename
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    },
    { -- which key
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end,
    },
    { -- scrollbar
      "petertriho/nvim-scrollbar",
      config = function()
        require("scrollbar").setup()
      end,
    },
    -- { -- symboloutline column
    --   "simrat39/symbols-outline.nvim",
    --   config = function()
    --     -- require("plugins.symbolsoutline")
    --   end,
    -- },
    -- { -- bufferline
    --   'akinsho/bufferline.nvim',
    --   config = function()
    --     -- require("plugins.bufferline")
    --   end,
    -- }
    -- ############## DUNGEON -- HERE LIE TEMP, OLD & DEPRECATED PLUGINS ##################
    -- use({ -- keep windows in position
    -- 	"luukvbaal/stabilize.nvim",
    -- 	config = function()
    -- 		require("stabilize").setup({
    -- 			ignore = { -- do not manage windows matching these file/buftypes
    -- 				filetype = { "list", "help" },
    -- 				buftype = { "terminal" },
    -- 			},
    -- 		})
    -- 	end,
    -- })

    -- use({ -- better quick fix buffer
    -- 	"kevinhwang91/nvim-bqf",
    -- 	config = function()
    -- 		require("plugins.bqf")
    -- 	end,
    -- })

    -- use({
    -- 	"michaelb/sniprun",
    -- 	run = "bash ./install.sh",
    -- 	config = function()
    -- 		require("plugins.sniprun")
    -- 	end,
    -- })

    -- use({ -- DAP
    -- 	"mfussenegger/nvim-dap",
    -- 	dependencies = {
    -- 		"nvim-telescope/telescope-dap.nvim",
    -- 		"theHamsta/nvim-dap-virtual-text",
    -- 		"rcarriga/nvim-dap-ui",
    -- 	},
    -- 	config = function()
    -- 		require("plugins.lsp.dap")
    -- 	end,
    -- })
    --

    -- { -- zenmode
    --   "Pocco81/true-zen.nvim",
    --   config = function()
    --     require("plugins.truezen")
    --   end,
    -- },
}
