require("yabs"):setup({
	languages = { -- List of languages in vim's `filetype` format
		lua = {
			tasks = {
				run = {
					command = "luafile %", -- The command to run (% and other wildcards will be automatically expanded)
					type = "shell", -- The type of command (can be `vim`, `lua`, or `shell`, default `shell`)
				},
			},
		},
		c = {
			default_task = "build_and_run",
			tasks = {
				build = {
					command = "make",
					output = "quickfix", -- buffer, consolation, echo, quickfix, terminal, or none
					opts = {
						open_on_run = "always",
					},
				},
				run = { -- You can specify as many tasks as you want per
					-- filetype
					command = "./out",
					output = "terminal",
				},

				build_and_run = { -- Setting the type to lua means the command
					command = function()
						require("yabs"):run_task("build", {
							-- first para `Job` is https://github.com/nvim-lua/plenary.nvim#plenaryjob
							on_exit = function(exit_code)
                vim.cmd("lua require('FTerm').scratch({ cmd = './run' }")
								if exit_code ~= 0 then
									-- require("yabs").languages.c:run_task("run")
                  vim.cmd("lua require('FTerm').scratch({ cmd = './run' }")
								end
							end,
						})
					end,
					type = "lua",
				},
			},
		},
	},
	opts = { -- Same values as `language.opts`
		output_types = {
			quickfix = {
				open_on_run = "auto",
			},
		},
	},
})
