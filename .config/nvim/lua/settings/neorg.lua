require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.keybinds"] = {
			config = {
				neorg_leader = "<Leader>o",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					home = "/home/carson/files/documents/org/",
					gtd = "/home/carson/files/documents/org/gtd",
					notes = "/home/carson/files/documents/org/notes/",
				},
				autochdir = true, -- Automatically change the directory to the current workspace's root every time
				index = "index.norg",
				last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt", -- The location to write and read the workspace cache file
			},
		},

		["core.gtd.base"] = {
			config = {
				workspace = "gtd",
				inbox = "inbox.norg",
			},
		},
		["core.integrations.nvim-cmp"] = {
			config = {},
		},
		["core.norg.concealer"] = {
			config = {},
		},
		["core.integrations.treesitter"] = {
			config = {},
		},
		["core.highlights"] = {
			config = {},
		},
		["core.gtd.ui"] = {
			config = {
				index = "index.neorg",
				last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace", -- The location to write and read the workspace cache file
			},
		},
	},
})
