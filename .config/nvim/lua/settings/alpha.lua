math.randomseed(os.time())
local alpha = require("alpha")
local fortune = require("alpha.fortune")
-- local colors_all = { "Comment", "Constant", "Number", "Identifier", "Label", "Type", "todo", "Normal", "PreProc", "Error", "Statement", "Ignore", "Function", "String"}
-- no repeating colors
local colors = { "Comment", "Constant", "Number", "Identifier", "Label", "Type", "Error", "Ignore" }
local icons = {}
local titles = {}

local function pick_and_remove(list)
  local num = math.random(#list)
  local val = list[num]
  table.remove(list, num)
  return val
end

-- TITLES
table.insert(titles, {
  " ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
  " ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
  "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
  "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
  "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
  "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
})
table.insert(titles, {
  "    _   ____________ _    ________  ___",
  "   / | / / ____/ __ \\ |  / /  _/  |/  /",
  "  /  |/ / __/ / / / / | / // // /|_/ / ",
  " / /|  / /___/ /_/ /| |/ // // /  / /  ",
  "/_/ |_/_____/\\____/ |___/___/_/  /_/   ",
})
table.insert(titles, {
  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
})
table.insert(titles, {
  "███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄  ",
  "███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄",
  "███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███",
  "███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███",
  "███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███",
  "███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███",
  "███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███",
  " ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀ ",
})
table.insert(titles, {
  " ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ",
  "•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪",
  "▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·",
  "██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌",
  "▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀",
})
table.insert(titles, {
  " ▄▀▀▄ ▀▄  ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄   ▄▀▀▄ ▄▀▀▄  ▄▀▀█▀▄    ▄▀▀▄ ▄▀▄",
  "█  █ █ █ ▐  ▄▀   ▐ █      █ █   █    █ █   █  █  █  █ ▀  █",
  "▐  █  ▀█   █▄▄▄▄▄  █      █ ▐  █    █  ▐   █  ▐  ▐  █    █",
  "  █   █    █    ▌  ▀▄    ▄▀    █   ▄▀      █       █    █ ",
  "▄▀   █    ▄▀▄▄▄▄     ▀▀▀▀       ▀▄▀     ▄▀▀▀▀▀▄  ▄▀   ▄▀  ",
  "█    ▐    █    ▐                       █       █ █    █   ",
  "▐         ▐                            ▐       ▐ ▐    ▐   ",
})
table.insert(titles, {
  "   ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█",
  "    █  █▀   ▀  █   █      █  ██ █ █ █",
  "██   █ ██▄▄    █   █ █     █ ██ █ ▄ █",
  "█ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █",
  "█  █ █ ▀███▀           █  █   ▐    █ ",
  "█   ██                  █▐        ▀  ",
  "                        ▐            ",
})
table.insert(titles, {
".______  ._______._______  .___     .___ ._____.___ ",
":      \\ : .____/: .___  \\ |   |___ : __|:         |",
"|       || : _/\\ | :   |  ||   |   || : ||   \\  /  |",
"|   |   ||   /  \\|     :  ||   :   ||   ||   |\\/   |",
"|___|   ||_.: __/ \\_. ___/  \\      ||   ||___| |   |",
"    |___|   :/      :/       \\____/ |___|      |___|",
})
table.insert(titles, {
"      ::::    ::: :::::::::: ::::::::  :::     ::: :::::::::::   :::   :::",
"     :+:+:   :+: :+:       :+:    :+: :+:     :+:     :+:      :+:+: :+:+:",
"    :+:+:+  +:+ +:+       +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+",
"   +#+ +:+ +#+ +#++:++#  +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+ ",
"  +#+  +#+#+# +#+       +#+    +#+  +#+   +#+      +#+     +#+       +#+  ",
" #+#   #+#+# #+#       #+#    #+#   #+#+#+#       #+#     #+#       #+#   ",
"###    #### ########## ########      ###     ########### ###       ###    ",
})
table.insert(titles, {
"@@@  @@@  @@@@@@@@   @@@@@@   @@@  @@@  @@@  @@@@@@@@@@ ",
"@@@@ @@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@  @@@@@@@@@@@",
"@@!@!@@@  @@!       @@!  @@@  @@!  @@@  @@!  @@! @@! @@!",
"!@!!@!@!  !@!       !@!  @!@  !@!  @!@  !@!  !@! !@! !@!",
"@!@ !!@!  @!!!:!    @!@  !@!  @!@  !@!  !!@  @!! !!@ @!@",
"!@!  !!!  !!!!!:    !@!  !!!  !@!  !!!  !!!  !@!   ! !@!",
"!!:  !!!  !!:       !!:  !!!  :!:  !!:  !!:  !!:     !!:",
":!:  !:!  :!:       :!:  !:!   ::!!:!   :!:  :!:     :!:",
" ::   ::   :: ::::  ::::: ::    ::::     ::  :::     :: ",
"::    :   : :: ::    : :  :      :      :     :      :  ",
})
table.insert(titles, {
  "`MM\\     `M'`MMMMMMMMM  6MMMMb  `Mb(     )d' `MM`MMb     dMM'",
  " MMM\\     M  MM      \\ 8P    Y8  YM.     ,P   MM MMM.   ,PMM",
  " M\\MM\\    M  MM       6M      Mb `Mb     d'   MM M`Mb   d'MM",
  " M \\MM\\   M  MM    ,  MM      MM  YM.   ,P    MM M YM. ,P MM",
  " M  \\MM\\  M  MMMMMMM  MM      MM  `Mb   d'    MM M `Mb d' MM",
  " M   \\MM\\ M  MM    `  MM      MM   YM. ,P     MM M  YM.P  MM",
  " M    \\MM\\M  MM       MM      MM   `Mb d'     MM M  `Mb'  MM",
  " M     \\MMM  MM       YM      M9    YM,P      MM M   YP   MM",
  " M      \\MM  MM      / 8b    d8     `MM'      MM M   `'   MM",
  "_M_      \\M _MMMMMMMMM  YMMMM9       YP      _MM_M_      _MM",
})
table.insert(titles, {
  "`7MN.   `7MF'`7MM\"\"\"YMM    .g8\"\"8q.`7MMF'   `7MF'`7MMF'`7MMM.     ,MMF'",
  "  MMN.    M    MM    `7  .dP'    `YM.`MA     ,V    MM    MMMb    dPMM  ",
  "  M YMb   M    MM   d    dM'      `MM VM:   ,V     MM    M YM   ,M MM  ",
  "  M  `MN. M    MMmmMM    MM        MM  MM.  M'     MM    M  Mb  M' MM  ",
  "  M   `MM.M    MM   Y  , MM.      ,MP  `MM A'      MM    M  YM.P'  MM  ",
  "  M     YMM    MM     ,M `Mb.    ,dP'   :MM;       MM    M  `YM'   MM  ",
  ".JML.    YM  .JMMmmmmMMM   `\"bmmd\"'      VF      .JMML..JML. `'  .JMML.",
})
table.insert(titles, {
"ooooo      ooo oooooooooooo   .oooooo.   oooooo     oooo ooooo ooo        ooooo",
"`888b.     `8' `888'     `8  d8P'  `Y8b   `888.     .8'  `888' `88.       .888'",
" 8 `88b.    8   888         888      888   `888.   .8'    888   888b     d'888 ",
" 8   `88b.  8   888oooo8    888      888    `888. .8'     888   8 Y88. .P  888 ",
" 8     `88b.8   888    \"    888      888     `888.8'      888   8  `888'   888 ",
" 8       `888   888       o `88b    d88'      `888'       888   8    Y     888 ",
"o8o        `8  o888ooooood8  `Y8bood8P'        `8'       o888o o8o        o888o",
})
table.insert(titles, {
".   ..---. .--..       .--.--.    .",
"|\\  ||    :    :\\     /   |  |\\  /|",
"| \\ ||--- |    | \\   /    |  | \\/ |",
"|  \\||    :    ;  \\ /     |  |    |",
"'   ''---' `--'    '    --'--'    '",
})
-- ASCII ART ICONS
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
  "███████████████████████████████████████",
  "█████████████▀▀▀░░░░░░░▀▀▀█████████████",
  "██████████▀░░░░░░░░░░░░░░░░░▀██████████",
  "█████████│░░░░░░░░░░░░░░░░░░░│█████████",
  "████████▌│░░░░░░░░░░░░░░░░░░░│▐████████",
  "████████░└┐░░░░░░░░░░░░░░░░░┌┘░████████",
  "████████░░└┐░░░░░░░░░░░░░░░┌┘░░████████",
  "████████░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░████████",
  "████████▌░│██████▌░░░▐██████│░▐████████",
  "█████████░│▐███▀▀░░▄░░▀▀███▌│░█████████",
  "████████▀ ┘░░░░░░░▐█▌░░░░░░░└ ▀████████",
  "████████▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄████████",
  "██████████▄ ┘██▌░░░░░░░▐██└ ▄██████████",
  "███████████░░▐█ ┬┬┬┬┬┬┬ █▌░░███████████",
  "██████████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐██████████",
  "███████████▄░░░└┴┴┴┴┴┴┴┘░░░▄███████████",
  "█████████████▄░░░░░░░░░░░▄█████████████",
  "████████████████▄▄▄▄▄▄▄████████████████",
  "███████████████████████████████████████",
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
table.insert(icons, {
  "                                 ▒█▒  ",
  "                                 █ █  ",
  "                                 █████",
  "                                 ██▒▓ ",
  "                                  █   ",
  "             ▒▒███▒▒              █▓  ",
  "           ▓██████████▒           ▓█  ",
  "         ▒██████████████░         ▓█  ",
  "        █████████████████▒        ██  ",
  "       ████████████████████░      ██  ",
  "      ██████████████████████▒    ▓██  ",
  "     █████████████████████████░ ▒██▒  ",
  "    ███████████████████████████████   ",
  "   ███████████████████████████████▓   ",
  "  ████████████████████████████████    ",
  "░████████████████████████████████     ",
  "████████████████████████████████      ",
  "██████████▓▒ ▒█████████▒▒████▒        ",
  "▒██████▓█    ▓███████▒                ",
  " ░▒▒▓▒       ████▒                    ",
  "            ▒█▒▒█▒                    ",
  "             █░ █░                    ",
  "             █  █                     ",
  "             █  █                     ",
  "            ░█  █▒                    ",
  "            ▒█  ░█                    ",
  "            ▓█   ██                   ",
  "            ██   ▓████▒               ",
  "            ▒████▒                    ",
})
table.insert(icons, {
  "▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓ ",
  "▓╫ ▄▀            ▄▀           ▄▀ ╫▓ ",
  "▓╫ ▀▄           ▐█            ▀▄ ╫▓ ",
  "▓╫ ▄▌▄           ▀▄           ▄▌▄╫▓ ",
  "▓▄▀░▓░▀▄          ▌         ▄▀░▓░▀▓ ",
  "▓░░░░░░░▌      ▄▄▀▀▄▄      ▐▓░░░░░▓ ",
  "▓▓░░░░░▓▀    ▄▀░░▓▓░░▀▄    ▀▄░░░░░▓ ",
  "▓╫▓█▓█▓     ▐▓░░░░░░░░▓▌     ▓█▓█▓▓ ",
  "▓╫▐░░░▌     ██▀▀▀▀▀▀▀▀██     ▐░░░╫▓ ",
  "▓╫▐░█░▌   ▄▄████████████▄▄   ▐░█░╫▓ ",
  "▓╫▐░░░▌   ▐▓▓▓▌▐▒▓▓▒▌▐▓▓▓▌   ▐░░░╫▓ ",
  "▓╫▐░█░▌   ▐▓▓▓▌▐▓▒▒▓▌▐▓▓▓▌   ▐░█░╫▓ ",
  "▓╫▐░░░▌▄▄▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▄▐░░░╫▓ ",
  "▓╫▐░█░███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███░█░╫▓ ",
  "▓╫▐░░░▌░█▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▒▒▐░█░╫▓ ",
  "◙═════════════════════════════════◙ ",
})
table.insert(icons, {
  "                ____----------- _____",
  "\\~~~~~~~~~~/~_--~~~------~~~~~     \\",
  " `---`\\  _-~      |                   \\",
  "   _-~  <_         |                     \\[]",
  ' / ___     ~~--[""] |      ________--------_',
  "> /~` \\    |-.   `\\~~.~~~~~                _ ~ - _",
  " ~|  ||\\%  |       |    ~  ._                ~ _   ~ ._",
  "   `_//|_%  \\      |          ~  .              ~-_   /\\",
  "          `--__     |    _-____  /\\               ~-_ \\/.",
  "               ~--_ /  ,/ -~-_ \\ \\/          _______---~/",
  "                   ~~-/._<   \\ \\`~~~~~~~~~~~~~     ##--~/",
  "                         \\    ) |`------##---~~~~-~  ) )",
  "                          ~-_/_/                  ~~ ~~",
})
table.insert(icons, {
  "                   '",
  "            *          .",
  "                   *       '",
  "              *                *",
  "   *   '*",
  "           *",
  "                *",
  "                       *",
  "               *",
  "                     *",
  "         .                      .",
  "         .                      ;",
  "         :                  - --+- -",
  "         !           .          !",
  "         |        .             .",
  "         |_         +",
  "      ,  | `.",
  "--- --+-<#>-+- ---  --  -",
  "      `._|_,'",
  "         T",
  "         |",
  "         !",
  "         :         . : ",
  "         .       *",
})
table.insert(icons, {
  "                                   .         ;  ",
  "      .              .              ;%     ;;   ",
  "        ,           ,                :;%  %;   ",
  "         :         ;                   :;%;'     .,   ",
  ",.        %;     %;            ;        %;'    ,;",
  "  ;       ;%;  %%;        ,     %;    ;%;    ,%'",
  "   %;       %;%;      ,  ;       %;  ;%;   ,%;' ",
  "    ;%;      %;        ;%;        % ;%;  ,%;'",
  "     `%;.     ;%;     %;'         `;%%;.%;'",
  "      `:;%.    ;%%. %@;        %; ;@%;%'",
  "         `:%;.  :;bd%;          %;@%;'",
  "           `@%:.  :;%.         ;@@%;'   ",
  "             `@%.  `;@%.      ;@@%;         ",
  "               `@%%. `@%%    ;@@%;        ",
  "                 ;@%. :@%%  %@@%;       ",
  "                   %@bd%%%bd%%:;     ",
  "                     #@%%%%%:;;",
  "                     %@@%%%::;",
  "                     %@@@%(o);  . '         ",
  "                     %@@@o%;:(.,'         ",
  "                 `.. %@@@o%::;         ",
  "                    `)@@@o%::;         ",
  "                    .%@@@@%::;         ",
  "                    ;%@@@@%::;.          ",
  "                   ;%@@@@%%:;;;. ",
  "               ...;%@@@@@%%:;;;;,..    ",
})
table.insert(icons, {
  "  -----                                                               -----",
  "1 | H |                                                               |He |",
  "  |---+----                                       --------------------+---|",
  "2 |Li |Be |                                       | B | C | N | O | F |Ne |",
  "  |---+---|                                       |---+---+---+---+---+---|",
  "3 |Na |Mg |3B  4B  5B  6B  7B |    8B     |1B  2B |Al |Si | P | S |Cl |Ar |",
  "  |---+---+---------------------------------------+---+---+---+---+---+---|",
  "4 | K |Ca |Sc |Ti | V |Cr |Mn |Fe |Co |Ni |Cu |Zn |Ga |Ge |As |Se |Br |Kr |",
  "  |---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---|",
  "5 |Rb |Sr | Y |Zr |Nb |Mo |Tc |Ru |Rh |Pd |Ag |Cd |In |Sn |Sb |Te | I |Xe |",
  "  |---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---|",
  "6 |Cs |Ba |LAN|Hf |Ta | W |Re |Os |Ir |Pt |Au |Hg |Tl |Pb |Bi |Po |At |Rn |",
  "  |---+---+---+------------------------------------------------------------",
  "7 |Fr |Ra |ACT|",
  "  -------------",
  "              -------------------------------------------------------------",
  "   Lanthanide |La |Ce |Pr |Nd |Pm |Sm |Eu |Gd |Tb |Dy |Ho |Er |Tm |Yb |Lu |",
  "              |---+---+---+---+---+---+---+---+---+---+---+---+---+---+---|",
  "   Actinide   |Ac |Th |Pa | U |Np |Pu |Am |Cm |Bk |Cf |Es |Fm |Md |No |Lw |",
  "              -------------------------------------------------------------",
})
table.insert(icons, {
  "  [___[___[___[___[___[___[___[___[___[___[___[___[___[",
  "   ||            ||     ,-'\"'\"'\"'-.    ||           ||",
  "   ||            ||    /           \\   ||           ||",
  "   ||            ||   /             \\  ||           ||",
  "   ||            ||  /               \\ ||           ||   ,",
  "   ||            || /_.--=========--._\\||   ,       || .'",
  "   ||            || '.::::: | | :::::.'||   '._     || \\",
  "   '================= '--...| |...--' =========\\=====' /",
  "                ,--._,--.   | |                 `.     |",
  "             ,-'| O \\ `.;   | |                   ]_.._[",
  "            '   '._.'   \\   | |            _______'....'_____",
  "           /      __,  ;|   | |           |      _|  _______ |",
  "       _,.' '._     `'='    | |    __     |-      | |`-._   `-.",
  "   .-'  /\\     `---..\\      | |    ||     |    -  | | -  '.__.-'",
  " .'    /  `._        /`.__ _| |___(__)____| _     | |_    |    |",
  "/      |     `--,.,.| `.::/;/ |-----------|      -| |    -|    |",
  "|      /`.          ,`-._ | | '     |     |    _  | |-  _ |    |",
  "|_____|__ `-,..-.-.'     `--.._     |     |_      | |_____|__.-'",
  "\\::::::::\\;;\\    /      /`'  .`'`. o|o    |      -|   _,.-''\\",
  " |       |  |   '      |    ;    ;  |    /`--.._ /_.-'      |",
  " |       |  |_  \\     __..--`._.' __|___ |-     |           |`-._",
  " |       |  | `'`-.--(=:=:=:=) ----------|    _ |        _.-' _.-'",
  " |    `. |  | __,.,--|'''''''|           |_-    |    _.-' _.-'",
  " ^-------^--^`       |       |             `-.__|_.-' _.-'",
  " `--..__             '-------'                    _.-'",
  "        `--..__                              _..-'",
  "               `--..__                 _.---'",
  "                      `--..______...--'",
})
table.insert(icons, {
  "                                  .                   .",
  "                              _..-''\"\"\"\\          _.--'\"\"\"\\",
  "                              |         L         |        \\",
  "                  _           / _.-.---.\\.        / .-.----.\\",
  "                _/-|---     _/<\"---'\"\"\"\"\"\\\\`.    /-'--''\"\"\"\"\"\\",
  "               |       \\     |            L`.`-. |            L",
  "               /_.-.---.L    |            \\  \\  `|            J`.",
  "             _/--'\"\"\"\"  \\    F            \\L  \\  |             L",
  "               L      `. L  J  _.---.-\"\"\"-.\\`. L_/ _.--|\"\"\"\"\"--.\\ `.",
  "               |        \\+. /-\"__.--'\"\"\"\"   \\ `./'\"---'\"\"\"\"\"\"   \\`. `.",
  "               F   _____ \\ `F\"        `.     \\  \\                L `.",
  "              /.-'\"_|---'\"\\ |           `    JL |                 L  `.`.",
  "             <-'\"\"         \\|    _.-.------._ A J    _.-.-----`.--|   ``.`.",
  "              L         `. |/.-'\"_.-`---'\"\"\\.\"| /-'\"---'\"\"\"\"\"   \\`.\\.  \\ `.`.",
  "              |  _.------\\.<'\"\"\"            L\\ L\\                `.`\\`. \\  `.",
  "         _.-'//'\"--'\"\"\"   L\\|       ________\\ `.F     ___.-------._L \\ `-\\   \\`.",
  "        /___| F             F _.--'\"_|-------L  /_.-'\"_.-|-'\"\"\"\"\"\"\"\\  L   L   `.`.",
  "            | F  _.-'|\"\"\"\"\"/'\"-'\"\"\"          J <'\"\"\"                L J   |     `.`.",
  "            |/-'-''/|\"\"\\ )-|\\                 F \\                   |  L .'\"\"\"`\\\"\"-\\\\_",
  "             F`-'-'-(`-')  | \\                F  \\                  |___`\"\"\"`.\"\"`.-'\"",
  "------------/        `-'---|  F               L   L             __     |\"\"\"\"\"`-'\"__________",
  "          .'_         |    |__L          __  J__  |    _.--'\"\"\"\"   `\".----'\".'",
  "         '\"\"\"\"\"\"\"\"\"\"\"\"|--._+--F _.-'\"\"||\"   \"\"\"___/.-'\"   ||-'\"/\"\"\"\"\" \\_. .'",
  "         J------------(___\\__/'_____.--------'-------'\"\"\"\"\"\"\"\"           /",
  "         `-.                                        _.__.__.__.____     J_.-._",
  "    .'`-._ (-`--`---.'--._`---._.-'`-._.-'_.-'``-._'               `-''-'",
})
table.insert(icons, {
  "                                     |__",
  "                                     |\\/",
  "                                     ---",
  "                                     / | [",
  "                              !      | |||",
  "                            _/|     _/|-++'",
  "                        +  +--|    |--|--|_ |-",
  "                     { /|__|  |/\\__|  |--- |||__/",
  "                    +---------------___[}-_===_.'____                 /\\",
  "                ____`-' ||___-{]_| _[}-  |     |_[___\\==--            \\/   _",
  " __..._____--==/___]_|__|_____________________________[___\\==--____,------' .7",
  "|                                                                     BB-61/",
  " \\_________________________________________________________________________|",
})
table.insert(icons, {
  "            .        +          .      .          .",
  "     .            _        .                    .",
  "  ,              /;-._,-.____        ,-----.__",
  " ((        .    (_:#::_.:::. `-._   /:, /-._, `._,",
  "  `                 \\   _|`\"=:_::.`.);  \\ __/ /",
  "                      ,    `./  \\:. `.   )==-'  .",
  "    .      ., ,-=-.  ,\\, +#./`   \\:.  / /           .",
  ".           \\/:/`-' , ,\\ '` ` `   ): , /_  -o",
  "       .    /:+- - + +- : :- + + -:'  /(o-) \\)     .",
  "  .      ,=':  \\    ` `/` ' , , ,:' `'--\".--\"---._/`7",
  "   `.   (    \\: \\,-._` ` + '\\, ,\"   _,--._,---\":.__/",
  "              \\:  `  X` _| _,\\/'   .-'",
  ".               \":._:`\\____  /:'  /      .           .",
  "                    \\::.  :\\/:'  /              +",
  "   .                 `.:.  /:'  }      .",
  "           .           ):_(:;   \\           .",
  "                      /:. _/ ,  |",
  "                   . (|::.     ,`                  .",
  "     .                |::.    {\\",
  "                      |::.\\  \\ `.",
  "                      |:::(\\    |",
  "              O       |:::/{ }  |                  (o",
  "               )  ___/#\\::`/ (O \"==._____   O, (O  /`",
  "          ~~~w/w~\"~~,\\` `:/,-(~`\"~~~~~~~~\"~o~\\~/~w|/~",
  "      ~~~~~~~~~~~~~~~~~~~~~~~\\\\W~~~~~~~~~~~~\\|/~~",
})
table.insert(icons, {
  -- "-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----",
  "           . _..::__:  ,-\"-\"._        |7       ,     _,.__",
  "   _.___ _ _<_>`!(._`.`-.    /         _._     `_ ,_/  '  '-._.---.-.__",
  ">.{     \" \" `-==,',._\\{  \\  / {)      / _ \">_,-' `                mt-2_",
  "  \\_.:--.       `._ )`^-. \"'       , [_/(                       __,/-'",
  " '\"'     \\         \"    _L        oD_,--'                )     /. (|",
  "          |           ,'          _)_.\\\\._<> 6              _,' /  '",
  "          `.         /           [_/_'` `\"(                <'}  )",
  "           \\\\    .-. )           /   `-'\"..' `:.#          _)  '",
  "    `        \\  (  `(           /         `:\\  > \\  ,-^.  /' '",
  "              `._,   \"\"         |           \\`'   \\|   ?_)  {\\",
  "                 `=.---.        `._._       ,'     \"`  |' ,- '.",
  "                   |    `-._         |     /          `:`<_|h--._",
  "                   (        >        .     | ,          `=.__.`-'\\",
  "                    `.     /         |     |{|              ,-.,\\     .",
  "                     |   ,'           \\   / `'            ,\"     \\",
  "                     |  /              |_'                |  __  /",
  "                     | |                                  '-'  `-'   \\.",
  "                     |/                                         \"    /",
  "                     \\.                                             '",
  "",
  "                      ,/            ______._.--._ _..---.---------._",
  "     ,-----\"-..?----_/ )      __,-'\"             \"                  (",
  "-.._(                  `-----'                                       `-",
  -- "-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----",
})
table.insert(icons, {
"                                        .o.",
"                                      o8888o",
"                                     d888888b",
"                                     `Y8888P'",
"                                 o .oood88booo. .o",
"                           Ybo  .88888888888888888.",
"                           \"8888888888888888888888888b,",
"                          .o88888888888888888888888888\"",
"                        Y88888888888888888888888888888b.",
"                       .o8888888888888888888888888888888.",
"                       8888888888888888888888888888888888",
"        o, ,db, ,o    d8888888888888888888888888888888888[",
"       .8888888888.   88888888888888888888888888888888888[",
"      o888888888888b ]88888888888888888888888888888888888",
"     d88888888888888o88888888888888888888888888888888888P",
" .o8o88888888888888888888888888888888888888888888888888\"",
"<8888888888888888888888888888888888888888888888888888K",
"  \"Y\"88888888888888888888888888888888888888888888888888o",
"     Y88888888888888\"88888888888888888888888888888888888b",
"      \"888888888888\" ]88888888888888888888888888888888888",
"       '8888888888`   88888888888888888888888888888888888[",
"        \"` \"YP\" `\"    \"8888888888888888888888888888888888[",
"                        888888888888888888888888888888888",
"                        d88888888888888888888888888888P'",
"                           ,8888888888888888888888888P'",
"                           dP\"  \"88888888888888888",
"                                 \" `\"\"\"Y88P\"\"\"' \"'",
"                                     .d8888b.",
"                                     Y888888P          ",
"                                      \"8888\"",
"                                        `\"'",
})

local but_color = pick_and_remove(colors)
local short_color = pick_and_remove(colors)
local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 35,
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
    button("w", "  > Enter Wiki" , ":VimwikiIndex<CR>"),
    button("d", "  > Daily Note" , ":VimwikiMakeDiaryNote<CR>"),
    button(".", "  > Load Directory Session " , ":SessionManager load_current_dir_session<cr>"),
    button("l", "  > Restore Last Session" , ":SessionManager load_last_session<CR>"),
    -- button("h", "  > Browse Sessions" , "<cmd>Telescope sessions [save_current=false]<cr>"),
    button("f", "  > Open File", ":Telescope find_files<CR>"),
    button("r", "  > Frequent Files" , "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>"),
    button("s", "  > Search Current Directory", ":Telescope live_grep<CR>"),
    button("p", "  > Browse Projects" , "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>"),
    -- button("t", "  > Terminal", "<CMD>call OpenTerm()<CR>"),
    -- button("o", "  > Open Directory " , "<cmd>silent !open .<cr>"),
    button("u", "  > Update Plugins", ":PackerSync<CR>"),
    button("q", "  > Quit Neovim", ":qa<CR>"),
  },
  opts = {
    spacing = 0,
  }
}

local foot_hl = pick_and_remove(colors)
local date = os.date("%a, %b %d, %I:%M:%S %p ")
local datedisplay = {
    type = "text",
    -- val = "     " .. date .. "      ",
    val = "   " .. date .. " ",
    opts = {
        position = "center",
        hl = foot_hl,
    }
}

local linepad = {
    type = "text",
    val = "-------------------------------------------------------------------",
    opts = {
        position = "center",
        hl = "Comment",
    }
}

local pluginNumber = #vim.tbl_keys(packer_plugins)
local pluginCount = {
    type = "text",
    val = "   " .. pluginNumber .. " plugins installed ",
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
        hl = pick_and_remove(colors)
      }
    },
    title = {
      type = "text",
      val = titles[math.random(#titles)],
      opts = {
        position = "center",
        hl = pick_and_remove(colors)
      }
    },
    advice = {
      type = "text",
      val = fortune(),
      opts = {
        position = "center",
        hl = "Function"
      }
    },
    buttons = buttons,
    datedisplay = datedisplay,
    pluginCount = pluginCount,
    linepad = linepad,
}

local opts = {
    layout = {
        section.title,
        section.advice,
        {type = "padding", val = 1},
        section.buttons,
        {type = "padding", val = 1},
        section.pluginCount,
        section.datedisplay,
        -- section.linepad,
        {type = "padding", val = 1},
        section.icon,
    },
    opts = {
        margin = 0
    },
}

-- Send config to alpha
alpha.setup(opts)
