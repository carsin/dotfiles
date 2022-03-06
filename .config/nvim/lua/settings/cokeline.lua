local get_hex = require("cokeline/utils").get_hex

local fg = get_hex("Normal", "fg")
local grey = get_hex("Comment", "fg")
local yellow = get_hex("Type", "fg")
local green = get_hex("String", "fg")

require("cokeline").setup({
	sidebar = {
		filetype = "NvimTree",
		components = {
			{
				text = "  NvimTree",
				hl = {
					fg = yellow,
					style = "bold",
				},
			},
		},
	},
	mappings = {
		cycle_prev_next = true,
	},
	rendering = {
		max_buffer_width = 50,
	},
	components = {
		{
			text = "|",
			fg = function(buffer)
				return buffer.is_modified and yellow or green
			end,
		},
		{
			text = function(buffer)
				return buffer.devicon.icon .. " "
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = function(buffer)
				return buffer.index .. ": "
			end,
		},
		{
			text = function(buffer)
				return buffer.unique_prefix
			end,
			fg = grey,
			style = "italic",
		},
		{
			text = function(buffer)
				return buffer.filename .. " "
			end,
			style = function(buffer)
				return buffer.is_focused and "bold" or nil
			end,
		},
		{
			text = " ",
			delete_buffer_on_left_click = true,
		},
		{
			text = " ",
		},
	},
})
