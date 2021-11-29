math.randomseed(os.time())
local alpha = require("alpha")
local fortune = require("alpha.fortune")
local icons = {}
local header = {
  type = "text",
  val = {
  "                                                   ",
  " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
  " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
  "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
  "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
  "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
  "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
  "   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
  "                                ░                  "
  },
  opts = {
    position = "center",
    hl = "AlphaHeader"
  }
}
table.insert(icons, {
  "                               ",
  "       ▄▀▀▀▀▀▀▀▀▀▀▄▄           ",
  "     ▄▀▀░░░░░░░░░░░░░▀▄        ",
  "   ▄▀░░░░░░░░░░░░░░░░░░▀▄      ",
  "   █░░░░░░░░░░░░░░░░░░░░░▀▄    ",
  "  ▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌   ",
  "  █░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█   ",
  " ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌  ",
  " █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█  ",
  " █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌ ",
  " ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌ ",
  "  █░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█ ",
  "  ▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█ ",
  "   ▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█ ",
  "    █░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌ ",
  "    ▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀  ",
  "    ▐▌░░▐▀▄░░░░░░░░░░░░░░░░█   ",
  "    ▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█    ",
  "    █░░░▀░░░░▀▄░░░░░░░░░░▄▀    ",
  "   ▐▌░░░░░░░░░░▀▄░░░░░░▄▀      ",
  "  ▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀        ",
  " ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄ ",
})

table.insert(icons, {
"+------+.      +------+       +------+       +------+      .+------+",
"|`.    | `.    |\\     |\\      |      |      /|     /|    .' |    .'|",
"|  `+--+---+   | +----+-+     +------+     +-+----+ |   +---+--+'  |",
"|   |  |   |   | |    | |     |      |     | |    | |   |   |  |   |",
"+---+--+.  |   +-+----+ |     +------+     | +----+-+   |  .+--+---+",
" `. |    `.|    \\|     \\|     |      |     |/     |/    |.'    | .' ",
"   `+------+     +------+     +------+     +------+     +------+'   ",
"                                                                    ",
"   .+------+     +------+     +------+     +------+     +------+.   ",
" .' |    .'|    /|     /|     |      |     |\\     |\\    |`.    | `. ",
"+---+--+'  |   +-+----+ |     +------+     | +----+-+   |  `+--+---+",
"|   |  |   |   | |    | |     |      |     | |    | |   |   |  |   |",
"|  ,+--+---+   | +----+-+     +------+     +-+----+ |   +---+--+   |",
"|.'    | .'    |/     |/      |      |      \\|     \\|    `. |   `. |",
"+------+'      +------+       +------+       +------+      `+------+",
"                                                                    ",
"   .+------+     +------+     +------+     +------+     +------+.   ",
" .' |      |    /|      |     |      |     |      |\\    |      | `. ",
"+   |      |   + |      |     +      +     |      | +   |      |   +",
"|   |      |   | |      |     |      |     |      | |   |      |   |",
"|  .+------+   | +------+     +------+     +------+ |   +------+.  |",
"|.'      .'    |/      /      |      |      \\      \\|    `.      `.|",
"+------+'      +------+       +------+       +------+      `+------+"
})

local function pick_color()
  local colors = {"String", "Identifier", "Keyword", "Number"}
  return colors[math.random(#colors)]
end


local heading = {
    type = "text",
    val = fortune(),
    opts = {
        position = "center",
        hl = "AlphaHeader",
    }
}

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 24,
        align_shortcut = "right",
        hl_shortcut = "AlphaButtons",
        hl = "AlphaButtons",
    }
    if keybind then
        opts.keymap = {"n", sc_, keybind, {noremap = true, silent = true}}
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
    }
end

-- TODO: fill this out
-- Buttons I want:
-- New file
-- Open wiki
-- Search Journal
-- Search files
-- Quit
local buttons = {
  type = "group",
  val = {
    button( "n", "  > New file" , ":enew <CR>"),
    button( "o", "  > Search for file", "Telescope find_files<CR>"),
    button( "r", "  > Open recent file"   , ":Telescope oldfiles<CR>"),
    button( "q", "  > Quit NVIM", ":qa<CR>"),
  },
  opts = {
    spacing = 1,
  }
}

local date = os.date("%a, %b %d ")
local footer = {
    type = "text",
    val = "┌─   Today is " .. date .. " ─┐",
    opts = {
        position = "center",
        hl = "AlphaFooter",
    }
}

local plugins = #vim.tbl_keys(packer_plugins)
local plugin_count = {
    type = "text",
    val = "└─    " .. plugins .. " plugins installed ─┘",
    opts = {
        position = "center",
        hl = "AlphaFooter",
    }
}

local section = {
    icon = {
      type = "text",
      val = icons[math.random(#icons)],
      opts = {
        position = "center",
        hl = "AlphaFooter",
      }
    },
    header = header,
    heading = heading,
    buttons = buttons,
    footer = footer,
    plugin_count = plugin_count,
}

local opts = {
    layout = {
        section.icon,
        section.header,
        section.heading,
        {type = "padding", val = 1},
        section.buttons,
        section.footer,
        section.plugin_count,
    },
    opts = {
        margin = 5
    },
}

-- Send config to alpha
alpha.setup(opts)
