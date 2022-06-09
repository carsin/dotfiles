-- download packer & bootstrap packages if it isn't installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_Bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Auto compile when there are changes in plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[packadd packer.nvim]])

local packer = require("packer")
packer.init({
  display = {
    title = "Packer",
    done_sym = "✓",
    error_syn = "☓",
    keybindings = { toggle_info = "o" },
  },
})

return packer.startup({
  function(use)
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("sainnhe/gruvbox-material")
    -- use('ellisonleao/gruvbox.nvim')
    use({ "norcalli/nvim-colorizer.lua", event = "BufRead" })
    use("chaoren/vim-wordmotion") -- more intuitive w/W motion
    use("wellle/targets.vim") -- more text objects to target
    use("skywind3000/asyncrun.vim") -- asynchronously run tasks such as make
    -- use("tpope/vim-fugitive")
    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    use("tpope/vim-unimpaired") -- handy ][ mappings that should be builtin
    -- use("tpope/vim-sleuth") -- heurestically set indent & other buf opts
    use("editorconfig/editorconfig-vim")
    use("christoomey/vim-tmux-navigator")
    use("famiu/bufdelete.nvim")
    use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    -- use("junegunn/vim-easy-align")
    use("kyazdani42/nvim-web-devicons")
    -- use("mbbill/undotree")
    -- use("RRethy/vim-illuminate") -- highlight matches of symbol under cursor
    use("ThePrimeagen/harpoon")
    use("stevearc/dressing.nvim") -- make default UI components look good
    use("nathom/filetype.nvim")
    use("zhimsel/vim-stay") -- automated view session creation & restore for buffers, sesssions and windows
    use("Konfekt/FastFold") -- don't recompute expr and syntax folds
    use("andymass/vim-matchup") -- extend %: highlight, navigate, and operate on sets of matching text

    use({ -- zettlekasten
      "mickael-menu/zk-nvim",
      -- requires = "SidOfc/mkdx", -- TODO(?)
      config = function()
        require("settings.zk")
      end,
    })

    use({ -- lsp config
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/nvim-lsp-installer",
        "mfussenegger/nvim-jdtls",
        "https://gitlab.com/yorickpeterse/nvim-dd",
        "p00f/clangd_extensions.nvim",
      },
      config = function()
        require("settings.lsp.lspconfig")
      end,
    })

    use({ -- treesitter
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "p00f/nvim-ts-rainbow",
        "RRethy/nvim-treesitter-endwise",
      },
      run = ":TSUpdate",
      config = function()
        require("settings.treesitter").setup()
      end,
    })

    use({ -- orgmode
      "nvim-neorg/neorg",
      config = function()
        require("settings.neorg")
      end,
      requires = "nvim-lua/plenary.nvim",
    })

    use({ -- lsp signature
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup({
          floating_window_above_cur_line = true,
          hint_prefix = "? ",
        })
      end,
    })

    use({ -- Rust Tools
      "simrat39/rust-tools.nvim",
      config = function()
        require("settings.lsp.rust-tools")
      end,
    })

    use({ -- telescope
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-project.nvim",
        "natecraddock/telescope-zf-native.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sqlite.lua" } },
      },
      config = function()
        require("settings.tscope")
      end,
    })

    use({ -- autopairs
      "windwp/nvim-autopairs",
      config = function()
        require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt", "vim", "markdown" }
        })
      end,
    })

    use({ -- nvim-cmp
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        -- "f3fora/cmp-spell",
        "hrsh7th/cmp-cmdline",
        "Furkanzmc/sekme.nvim",
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
      config = function()
        require("settings.lsp.cmp")
      end,
    })

    use({ -- FTerm
      "numtostr/FTerm.nvim",
      config = function()
        require("settings.fterm")
      end,
    })

    use({ -- Feline
      "feline-nvim/feline.nvim",
      config = function()
        require("settings.feline")
      end,
    })

    use({ -- Trouble
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("settings.trouble")
      end,
    })

    use({ -- better escape
      "jdhao/better-escape.vim",
      event = "InsertEnter",
      config = function()
        vim.g.better_escape_interval = 200
        vim.g.better_escape_shortcut = { "jk", "kj" }
      end,
    })

    use({ -- neo tree
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("settings.neotree")
      end,
    })

    use({ -- gitsigns
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "BufEnter", -- this makes the plugin work for some reason?
      after = "plenary.nvim",
      config = function()
        require("settings.gitsigns")
      end,
    })

    use({ -- AutoSaves the buffer
      "Pocco81/AutoSave.nvim",
      config = function()
        require("settings.autosave")
      end,
    })

    use({ -- tpopes commentary with extras such as gcA and gcO
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
    })

    use({ -- zenmode
      "Pocco81/TrueZen.nvim",
      config = function()
        require("settings.truezen")
      end,
    })

    use({ -- alpha startup screen; startify & dashboard but developed
      "goolord/alpha-nvim",
      requires = "Shatur/neovim-session-manager",
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
        require("settings.alpha")
      end,
    })

    use({ -- blankline indent indicator
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
    })

    use({ -- lsp status widget
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
    })

    use({ -- rooter
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
    })

    use({ -- jetpack
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").opts.ignore_case = false
        require("lightspeed").opts.safe_labels = {}
      end,
    })

    use({ -- increment numbers & more with +/-
      "zegervdv/nrpattern.nvim",
      config = function()
        -- Basic setup
        -- See below for more options
        require("nrpattern").setup()
      end,
    })

    use({ -- null ls
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("settings.lsp.nullls")
      end,
      requires = { "nvim-lua/plenary.nvim" },
    })

    use { -- winbar widget
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function()
        require("settings.lsp.gps")
      end
    }

    use {
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    }

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
    -- 		require("settings.bqf")
    -- 	end,
    -- })

    -- use({
    -- 	"michaelb/sniprun",
    -- 	run = "bash ./install.sh",
    -- 	config = function()
    -- 		require("settings.sniprun")
    -- 	end,
    -- })

    -- use({ -- symboloutline column
    --   "simrat39/symbols-outline.nvim",
    --   config = function()
    --     require("settings.symbolsoutline")
    --   end,
    -- })


    -- use({ -- DAP
    -- 	"mfussenegger/nvim-dap",
    -- 	requires = {
    -- 		"nvim-telescope/telescope-dap.nvim",
    -- 		"theHamsta/nvim-dap-virtual-text",
    -- 		"rcarriga/nvim-dap-ui",
    -- 	},
    -- 	config = function()
    -- 		require("settings.lsp.dap")
    -- 	end,
    -- })

    -- use({ -- which key
    --   "folke/which-key.nvim",
    --   config = function()
    --     require("which-key").setup({})
    --   end,
    -- })

    if Packer_Bootstrap then -- auto set up conf after cloning packer.nvim
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
    git = {
      clone_timeout = 120,
    },
    compile_path = vim.fn.stdpath("config") .. "/lua/compiled/packer_compiled.lua",
  },
})
