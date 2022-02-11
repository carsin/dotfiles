local true_zen = require("true-zen")

true_zen.setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 1,
		},
		left = {
			number = true,
			relativenumber = true,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 25,
			right_padding = 25,
			top_padding = 0,
			bottom_padding = 1,
			ideal_writing_area_width = {86},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			-- affected_higroups = {
			-- 	NonText = true,
			-- 	FoldColumn = true,
			-- 	ColorColumn = true,
			-- 	VertSplit = true,
			-- 	StatusLine = true,
			-- 	StatusLineNC = true,
			-- 	SignColumn = true,
			-- },
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = true,
		nvim_bufferline = true,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
		lightline = false,
		feline = false,
	},
	misc = {
		on_off_commands = true,
		ui_elements_commands = false,
		cursor_by_mode = true,
	}
})
