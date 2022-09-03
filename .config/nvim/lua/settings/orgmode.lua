-- ref https://github.com/kristijanhusak/neovim-config/blob/696aacbd4095c10fce5c9ed755b689be5c2ae5d1/nvim/lua/partials/orgmode_config.lua
-- TODO: https://github.com/nvim-orgmode/orgmode/pull/215

-- new parser conf
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.org = {
--   install_info = {
--     url = 'https://github.com/milisims/tree-sitter-org',
--     revision = 'main',
--     files = {'src/parser.c', 'src/scanner.cc'},
--   },
--   filetype = 'org',
-- }

-- working parser conf
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require("orgmode").setup({
	org_agenda_files = { "/home/carson/documents/org/*" },
	org_default_notes_file = "/home/carson/documents/org/notes.org",
	org_agenda_start_on_weekday = true,
	org_hide_emphasis_markers = true,
	org_todo_keywords = {'TODO(t)', 'NEXT(n)', '|', 'DONE(d)'},
	org_agenda_templates = {
		t = {
			description = "Refile",
			template = "* TODO %?\n  DEADLINE: %T",
		},
		T = {
			description = "Todo",
			template = "* TODO %?\n  DEADLINE: %T",
			target = "/home/carson/files/documents/org/todos.org",
		},
		w = {
			description = "Uni todo",
			template = "* TODO %?\n  DEADLINE: %T",
			target = "/home/carson/files/documents/org/university.org",
		},
	},
	notifications = {
		reminder_time = { 0, 1, 5, 10 },
		repeater_reminder_time = { 0, 1, 5, 10 },
		deadline_warning_reminder_time = { 0 },
		cron_notifier = function(tasks)
			for _, task in ipairs(tasks) do
				local title = string.format("%s (%s)", task.category, task.humanized_duration)
				local subtitle = string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title)
				local date = string.format("%s: %s", task.type, task.time:to_string())

				if vim.fn.executable("notify-send") then
					vim.loop.spawn("notify-send", {
						args = {
							"--icon=/home/kristijan/.config/nvim/pack/packager/start/orgmode/assets/orgmode_nvim.png",
							string.format("%s\n%s\n%s", title, subtitle, date),
						},
					})
				end
			end
		end,
	},
})
