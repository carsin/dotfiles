math.randomseed(os.time())
local alpha = require("alpha")
local fortune = require("alpha.fortune")
local icons = {}
local colors = {"String", "Identifier", "Keyword", "Number", "Constant", "PreProc", "Type", "Comment", "Normal"}
local function pick_color()
  local num = math.random(#colors)
  local val = colors[num]
  table.remove(colors, num)
  return val
end

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
  },
  opts = {
    position = "center",
    hl = pick_color()
  }
}
table.insert(icons, {
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

table.insert(icons, {
"     \\\\XXXXXX//",
"      XXXXXXXX",
"     //XXXXXX\\\\                      OOOOOOOOOOOOOOOOOOOO",
"    ////XXXX\\\\\\\\                     OOOOOOOOOOOOOOOOOOOO",
"   //////XX\\\\\\\\\\\\     |||||||||||||||OOOOOOOOOOOOOOOVVVVVVVVVVVVV",
"  ////////\\\\\\\\\\\\\\\\    |!!!|||||||||||OOOOOOOOOOOOOOOOVVVVVVVVVVV'",
" ////////  \\\\\\\\\\\\\\\\ .d88888b|||||||||OOOOOOOOOOOOOOOOOVVVVVVVVV'",
"////////    \\\\\\\\\\\\\\d888888888b||||||||||||            'VVVVVVV'",
"///////      \\\\\\\\\\\\88888888888||||||||||||             'VVVVV'",
"//////        \\\\\\\\\\Y888888888Y||||||||||||              'VVV'",
"/////          \\\\\\\\\\\\Y88888Y|||||||||||||| .             'V'",
"////            \\\\\\\\\\\\|iii|||||||||||||||!:::.            '",
"///              \\\\\\\\\\\\||||||||||||||||!:::::::.",
"//                \\\\\\\\\\\\\\\\           .:::::::::::.",
"/                  \\\\\\\\\\\\\\\\        .:::::::::::::::.",
"                    \\\\\\\\\\\\\\\\     .:::::::::::::::::::.",
"                     \\\\\\\\\\\\\\\\",
})


table.insert(icons, {
"                              .___.",
"          /)               ,-^     ^-.",
"         //               /           \\",
".-------| |--------------/  __     __  \\-------------------.__",
"|WMWMWMW| |>>>>>>>>>>>>> | />>\\   />>\\ |>>>>>>>>>>>>>>>>>>>>>>:>",
"`-------| |--------------| \\__/   \\__/ |-------------------'^^",
"         \\\\               \\    /|\\    /",
"          \\)               \\   \\_/   /",
"                            |       |",
"                            |+H+H+H+|",
"                            \\       /",
"                             ^-----^",
})

local adviceHeading = {
    type = "text",
    val = fortune(),
    opts = {
        position = "center",
        hl = pick_color(),
    }
}

local but_color = pick_color()
local short_color = pick_color()
local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 40,
        align_shortcut = "right",
        hl = but_color,
        hl_shortcut = short_color,
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

local buttons = {
  type = "group",
  val = {
    button("l", "  > Load last session" , ":LoadLastSession<CR>"),
    button("w", "  > Open wiki" , ":VimwikiIndex<CR>"),
    button("d", "  > Daily note" , ":VimwikiMakeDiaryNote<CR>"),
    button("h", "  > Browse sessions" , "<cmd>Telescope sessions [save_current=false]<cr>"),
    button("o", "  > Search files", ":Telescope find_files<CR>"),
    button("r", "  > Frequently opened files" , "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>"),
    button("p", "  > Browse projects" , "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>"),
    button("u", "  > Update plugins", ":PackerSync<CR>"),
    button("q", "  > Quit NVIM", ":qa<CR>"),
  },
  opts = {
    spacing = 0,
  }
}

local foot_hl = pick_color()
local date = os.date("%a, %b %d, %I:%M:%S %p ")
local datedisplay = {
    type = "text",
    val = "┌─       " .. date .. "    ─┐",
    opts = {
        position = "center",
        hl = foot_hl,
    }
}

local pluginNumber = #vim.tbl_keys(packer_plugins)
local pluginCount = {
    type = "text",
    val = "└─         " .. pluginNumber .. " plugins installed       ─┘",
    opts = {
        position = "center",
        hl = foot_hl,
    }
}

local section = {
    icon = {
      type = "text",
      val = icons[math.random(#icons)],
      opts = {
        position = "center",
        hl = pick_color()
      }
    },
    header = header,
    adviceHeading = adviceHeading,
    buttons = buttons,
    datedisplay = datedisplay,
    timedisplay = timedisplay,
    pluginCount = pluginCount,
}

local opts = {
    layout = {
        section.icon,
        section.header,
        section.adviceHeading,
        {type = "padding", val = 1},
        section.buttons,
        {type = "padding", val = 1},
        section.datedisplay,
        section.pluginCount,
    },
    opts = {
        margin = 0
    },
}

-- Send config to alpha
alpha.setup(opts)
