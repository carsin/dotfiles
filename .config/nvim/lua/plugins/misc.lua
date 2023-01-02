return {
  "folke/which-key.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "sainnhe/gruvbox-material",
  "norcalli/nvim-colorizer.lua",
  "chaoren/vim-wordmotion", -- more intuitive w/W motion
  "wellle/targets.vim", -- more text objects to target
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired", -- handy ][ mappings that should be builtin
  "editorconfig/editorconfig-vim",
  "christoomey/vim-tmux-navigator",
  "famiu/bufdelete.nvim",
  "antoinemadec/FixCursorHold.nvim", -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  "kyazdani42/nvim-web-devicons",
  { "mbbill/undotree", keys = { "<leader>u", "UndotreeToggle<CR>" } },
  "ThePrimeagen/harpoon",
  "zhimsel/vim-stay", -- automated view session creation & restore for buffers, sesssions and windows
  "andymass/vim-matchup", -- extend %: highlight, navigate, and operate on sets of matching text
  "SmiteshP/nvim-navic", -- lsp code context winbar component
  "wakatime/vim-wakatime", -- track editing statistics
  { "stevearc/dressing.nvim", event = "VeryLazy" }, -- make default UI components look good
  { "skywind3000/asyncrun.vim", lazy = false, keys = { "<F10>", ":call asyncrun#quickfix_toggle(7)" } }, -- asynchronously run tasks such as make
  { -- autopairs
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup {
        map_cr = true,
        map_complete = true,
        auto_select = true,
        ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
        check_ts = true,
        ts_config = {
          lua = { 'string' },
          javascript = { 'template_string' },
        },
        disable_filetype = { 'TelescopePrompt', 'vim', "markdown" },
      }
    end,
  },
  { -- better escape
    "jdhao/better-escape.vim",
    event = "InsertEnter",
    config = function()
      vim.g.better_escape_interval = 200
      vim.g.better_escape_shortcut = { "jk", "kj" }
    end,
  },
  { -- AutoSaves the buffer
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        execution_message = {},
        events = { "InsertLeave", "TextChanged", "WinLeave", "BufWinLeave" },
        write_all_buffers = false,
        clean_command_line_interval = 0,
        debounce_delay = 1000,
        conditions = {
          exists = true,
          filename_is_not = {},
          filetype_is_not = {},
          modifiable = true
        },
      })
    end,
  },
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
    keys = {
      { "s", "<Plug>Lightspeed_omni_s" },
      { "gs", "<Plug>Lightspeed_omni_gs" },
      { "gS", "<Plug>Lightspeed_omni_gS" },
    }
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
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = require("plugins.feline").colors.bg_hi,
        },
      })
    end,
  },
  { -- search lens (hl occurrences & number them)
    "kevinhwang91/nvim-hlslens",
    config = function()
      require('hlslens').setup()
      -- TODO: setup keymaps with lazy
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
    end
  },
  { -- modernized folds
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    config = function()
      require("ufo").setup()
    end
  },
  { -- floating filename statuslines
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      require("incline").setup({
        window = {
          margin = {
            vertical = 0,
            horizontal = 1,
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return {
            { icon, guifg = color },
            { " " },
            { filename },
          }
        end,
      })
    end
  }
  -- { -- symboloutline column
  --   "simrat39/symbols-outline.nvim",
  --   config = function()
  --     -- require("plugins.symbolsoutline")
  --   end,
  -- },
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
  -- { -- bufferline
  --   'akinsho/bufferline.nvim',
  --   config = function()
  --     -- require("plugins.bufferline")
  --   end,
  -- }

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
