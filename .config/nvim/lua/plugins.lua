-- download packer & bootstrap packages if it isn't installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
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
		use({ "norcalli/nvim-colorizer.lua", event = "BufRead" })
		use("ggandor/lightspeed.nvim")
		use("chaoren/vim-wordmotion") -- more intuitive w/W motion
		use("wellle/targets.vim") -- more text objects to target
		use("tpope/vim-surround")
		use("tpope/vim-repeat")
		use("tpope/vim-fugitive")
		use("christoomey/vim-tmux-navigator")
		use("famiu/bufdelete.nvim")
		use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		use("junegunn/vim-easy-align")
		use("kyazdani42/nvim-web-devicons")
		use("nathom/filetype.nvim")
		use("mbbill/undotree")
		use("tpope/vim-unimpaired") -- handy ][ mappings that should be builtin
		use("RRethy/vim-illuminate") -- highlight matches of symbol under cursor
		use("editorconfig/editorconfig-vim")
    use("lambdalisue/suda.vim") -- read and write as sudo

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

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("settings.lsp.nullls")
			end,
			requires = { "nvim-lua/plenary.nvim" },
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

		use({
			"nvim-neorg/neorg",
			config = function()
				require("settings.neorg")
			end,
			requires = "nvim-lua/plenary.nvim",
		})

		-- use({ -- orgmode TODO: Fix
		-- 	"nvim-orgmode/orgmode",
		-- 	config = function()
		-- 		require("settings.orgmode")
		-- 	end,
		-- 	requires = {
		-- 		"akinsho/org-bullets.nvim",
		-- 		"lukas-reineke/headlines.nvim",
		-- 	},
		-- })

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
				"nvim-telescope/telescope-ui-select.nvim",
				"jvgrootveld/telescope-zoxide",
				"LinArcX/telescope-env.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{ "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sqlite.lua" } },
			},
			config = function()
				require("settings.tscope")
			end,
		})

		use({ -- lspkind
			"onsails/lspkind-nvim",
			config = function()
				require("settings.lsp.lspkind")
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
				"f3fora/cmp-spell",
				"hrsh7th/cmp-cmdline",
				-- "Furkanzmc/sekme.nvim",
				"andersevenrud/cmp-tmux",
				"hrsh7th/cmp-nvim-lsp-signature-help",
			},
			config = function()
				require("settings.lsp.cmp")
			end,
		})

		use({ -- autopairs
			"windwp/nvim-autopairs",
			config = function()
				require("settings.autopairs")
			end,
		})

		use({ -- FTerm
			"numtostr/FTerm.nvim",
			config = function()
				require("settings.fterm")
			end,
		})

		use({ -- Feline
			"famiu/feline.nvim",
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

		use({ -- bufferline
			"akinsho/bufferline.nvim",
			requires = "kyazdani43/nvim-web-devicons",
			config = function()
				require("settings.bufferline")
			end,
		})

		-- use({
		--   "noib3/nvim-cokeline",
		--   config = function ()
		-- require("settings.cokeline")
		--   end
		-- })

		use({ -- nvim tree
			"kyazdani42/nvim-tree.lua",
      commit="3f4ed9b6c2598ab8304186486a0",
			config = function()
				require("settings.nvimtree")
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

		use({ -- DAP
			"mfussenegger/nvim-dap",
			requires = {
				"nvim-telescope/telescope-dap.nvim",
				"theHamsta/nvim-dap-virtual-text",
				"rcarriga/nvim-dap-ui",
			},
			config = function()
				require("settings.lsp.dap")
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

		-- use({ -- neogit, magit for neovim
		-- 	"TimUntersberger/neogit",
		-- 	requires = "nvim-lua/plenary.nvim",
		-- 	config = function()
		-- 		require("neogit").setup({})
		-- 	end,
		-- })

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

		use({ -- which key
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({})
			end,
		})

		use({ -- lsp status
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		})

		use({ -- keep windows in position
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup({
					ignore = { -- do not manage windows matching these file/buftypes
						filetype = { "list", "help" },
						buftype = { "terminal" },
					},
				})
			end,
		})

		use({ -- help managing crates
			"saecki/crates.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			event = { "BufRead Cargo.toml" },
			config = function()
				require("crates").setup()
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

	use({ -- build system TODO: not working; see yabs.lua
		"pianocomposer321/yabs.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
        require('settings.yabs')
		end,
	})
	if packer_bootstrap then -- auto set up conf after cloning packer.nvim
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
