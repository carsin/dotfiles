require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					home = "/home/carson/files/docs/org/home",
					gtd = "/home/carson/files/docs/org/gtd",

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

    -- ["core.gtd.ui"] = {
    --   config = {
    --     index = "index.neorg",
    --     last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace", -- The location to write and read the workspace cache file
    --   },
    -- }
	},
})
