local lsp = require("feline.providers.lsp")
local M = {}
local vi_mode_utils = require("feline.providers.vi_mode")
local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {},
}

force_inactive.filetypes = {
  "NvimTree",
  "dbui",
  "packer",
  "startify",
  "fugitive",
  "fugitiveblame",
}

force_inactive.buftypes = {
  "terminal",
}

local components = {
  active = {},
  inactive = {},
}
-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

local colors = {
  bg = "#282828",
  black = "#282828",
  yellow = "#d79921",
  byellow = "#fadb2f",
  cyan = "#689d6a",
  oceanblue = "#458588",
  bgreen = "#b8bb26", green = "#98971a",
  orange = "#d65d0e",
  violet = "#b16286",
  magenta = "#d3869b",
  white = "#a89984",
  fg = "#a89984",
  skyblue = "#83a598",
  red = "#fb4934",
  gray = "#a89984",
}

local vi_mode_colors = {
  NORMAL = "bgreen",
  OP = "green",
  INSERT = "red",
  VISUAL = "skyblue",
  BLOCK = "skyblue",
  LINES = "violet",
  REPLACE = "violet",
  ["V-REPLACE"] = "violet",
  ENTER = "cyan",
  MORE = "cyan",
  SELECT = "orange",
  COMMAND = "cyan",
  SHELL = "green",
  TERM = "green",
  NONE = "yellow",
}

local vi_mode_text = {
  NORMAL = "<|",
  OP = "<|",
  INSERT = "|>",
  VISUAL = "<>",
  LINES = "<>",
  BLOCK = "<>",
  REPLACE = "<>",
  ["V-REPLACE"] = "<>",
  ENTER = "<>",
  MORE = "<>",
  SELECT = "<>",
  COMMAND = "<|",
  SHELL = "<|",
  TERM = "<|",
  NONE = "<>",
}
-- LEFT

-- vi-mode
table.insert(components.active[1], {
  provider = "vi_mode",
  hl = function()
    local val = {}
    val.name = vi_mode_utils.get_mode_highlight_name()
    val.bg = vi_mode_utils.get_mode_color()
    val.fg = "bg"
    val.style = "bold"
    return val
  end,
  left_sep = "░▒▓█",
  right_sep = "█▓▒░ ",
  icon = "",
})

-- vi-symbol
-- table.insert(components.active[1], {
--   provider = function()
--     return vi_mode_text[vi_mode_utils.get_vim_mode()]
--   end,
--   hl = function()
--     local val = {}
--     val.fg = vi_mode_utils.get_mode_color()
--     val.bg = 'bg'
--     -- val.style = 'bold'
--     return val
--   end,
--   left_sep = ' ',
--   right_sep = ' ',
-- })

-- filename
table.insert(components.active[1], {
  provider = "file_info",
  file_modified_icon = "+",
  hl = {
    fg = "white",
    bg = "bg",
    -- style = 'bold'
  },
  type = "unique",
  right_sep = "",
})

-- asyncrun command status
table.insert(components.active[1], {
  -- provider = "%{g:asyncrun_status}",
  provider = function()
    local status_icon = ""
    local icon = ""
    if vim.g.asyncrun_status ~= nil then
      if vim.g.asyncrun_status == "stopped" then
        status_icon = " P "
        icon = " "
      elseif vim.g.asyncrun_status == "success" then
        status_icon = " ✓ "
        icon = " "
      elseif vim.g.asyncrun_status == "running" then
        status_icon = "   "
        icon = " "
      elseif vim.g.asyncrun_status == "failure" then
        status_icon = " ! "
        icon = " "
      end
    end
    return icon .. "%{g:asyncrun_status}" .. status_icon
  end,
  enabled = function()
    return (vim.g.asyncrun_status ~= nil and vim.g.asyncrun_status ~= "stopped") or vim.bo.filetype == "qf"
  end,
  hl = function()
    local fg = "gray"
    if vim.g.asyncrun_status ~= nil then
      if vim.g.asyncrun_status == "stopped" then
        fg = "gray"
      elseif vim.g.asyncrun_status == "success" then
        fg = "green"
      elseif vim.g.asyncrun_status == "running" then
        fg = "yellow"
      elseif vim.g.asyncrun_status == "failure" then
        fg = "red"
      end
    end
    return {
      fg = fg,
      bg = "bg",
    }
  end,
  left_sep = " ",
  right_sep = "",
})

-- gitBranch
table.insert(components.active[1], {
  provider = "git_branch",
  -- icon = " ",
  hl = {
    fg = "yellow",
    bg = "bg",
    -- style = 'bold'
  },
  right_sep = " ",
})

-- diffAdd
table.insert(components.active[1], {
  provider = "git_diff_added",
  icon = "+",
  hl = {
    fg = "green",
    bg = "bg",
    -- style = 'bold'
  },
  right_sep = " ",
})

-- diffModified
table.insert(components.active[1], {
  provider = "git_diff_changed",
  icon = "~",
  hl = {
    fg = "yellow",
    bg = "bg",
    -- style = 'bold'
  },
  right_sep = " ",
})

-- diffRemove
table.insert(components.active[1], {
  provider = "git_diff_removed",
  icon = "-",
  hl = {
    fg = "red",
    bg = "bg",
    -- style = 'bold'
  },
  right_sep = " ",
})

-- RIGHT
-- table.insert(components.active[3], {
--   provider = function()
--     local max_len = 50
--     local val = require("lsp-status").status()
--     if string.len(val) >= max_len then
--       val = "…" .. string.sub(val, 1, max_len) .. "…"
--     end
--     return val
--   end,
--   hl = "FlnStatus",
--   hl = {
--     fg = 'cyan',
--     style = 'bold'
--   },
-- })

-- diagnosticErrors
table.insert(components.active[3], {
  provider = "diagnostic_errors",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
  end,
  icon = "E",
  hl = {
    fg = "red",
    -- style = 'bold'
  },
  right_sep = "",
})

-- diagnosticWarn
table.insert(components.active[3], {
  provider = "diagnostic_warnings",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
  end,
  icon = "!",
  hl = {
    fg = "yellow",
    -- style = 'bold'
  },
  left_sep = " ",
})

-- diagnosticHint
table.insert(components.active[3], {
  provider = "diagnostic_hints",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
  end,
  icon = "?",
  hl = {
    fg = "bgreen",
    -- style = 'bold'
  },
  left_sep = " ",
  right_sep = "",
})

-- diagnosticInfo
table.insert(components.active[3], {
  provider = "diagnostic_info",
  enabled = function()
    return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
  end,
  icon = "i",
  hl = {
    fg = "cyan",
    -- style = 'bold'
  },
  left_sep = " ",
  right_sep = "",
})

-- LspName
table.insert(components.active[3], {
  provider = "lsp_client_names",
  icon = "",
  hl = {
    fg = "skyblue",
    bg = "bg",
    style = "bold",
  },
  left_sep = " ",
  right_sep = "",
})

-- LspStatus
-- table.insert(components.active[3], {
--   provider = function ()
--     local lsp_status = require('lsp-status')
--     lsp_status.register_progress()
--     return lsp_status.status()
--   end,
--   hl = {
--     fg = 'skyblue',
--     bg = 'bg',
--   },
--   left_sep = ' ',
--   right_sep = ''
-- })

-- fileSize
table.insert(components.active[3], {
  provider = "file_size",
  -- enabled = function()
  -- 	return vim.fn.getfsize(vim.fn.expand("%:t")) > 0
  -- end,
  hl = {
    fg = "red",
    bg = "bg",
    -- style = 'bold'
  },
  left_sep = " ",
  right_sep = "",
})

-- file format
table.insert(components.active[3], {
  provider = "file_format",
  hl = {
    fg = "gray",
    bg = "bg",
  },
  left_sep = " ",
  right_sep = "",
})

-- position
table.insert(components.active[3], {
  provider = "position",
  hl = {
    fg = "white",
    bg = "bg",
    style = "bold",
  },
  left_sep = " ",
  right_sep = " ",
})

-- fileType
table.insert(components.active[3], {
  provider = "file_type",
  hl = function()
    local val = {}
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon, name = require("nvim-web-devicons").get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), "fg")
    else
      val.fg = "white"
    end
    val.bg = "bg"
    -- val.style = 'bold'
    return val
  end,
  right_sep = "",
  left_sep = "",
})

-- linePercent
table.insert(components.active[3], {
  provider = "line_percentage",
  hl = {
    fg = "white",
    bg = "bg",
    style = "bold",
  },
  left_sep = " ",
})

-- scrollBar
table.insert(components.active[3], {
  provider = "scroll_bar",
  hl = {
    fg = "cyan",
    bg = "bg",
    style = "bold",
  },
  left_sep = " ",
})

-- INACTIVE
-- LEFT
-- fileType
table.insert(components.inactive[1], {
  provider = "file_type",
  hl = {
    fg = "black",
    bg = "cyan",
    style = "bold",
  },
  left_sep = {
    str = " ",
    hl = {
      fg = "NONE",
      bg = "cyan",
    },
  },
  right_sep = {
    {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "cyan",
      },
    },
    " ",
  },
})

-- filename
table.insert(components.inactive[1], {
  provider = "file_info",
  opts = {
    file_modified_icon = "+",
    file_readonly_icon = "-- READ ONLY",
    type = "full-path",
  },
})

-- RIGHT
-- fileSize
table.insert(components.inactive[2], {
  provider = "file_size",
  enabled = function()
    return vim.fn.getfsize(vim.fn.expand("%:t")) > 0
  end,
  hl = {
    fg = "white",
    bg = "bg",
    -- style = 'bold'
  },
  left_sep = " ",
  right_sep = " ",
})

require("feline").setup({
  theme = colors,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
})

local treesitter_context = require "settings.treesitter".treesitter_context
local winbar_components = {
  active = {},
  inactive = {}
}

-- Insert three sections (left, mid and right) for the active statusline
table.insert(winbar_components.active, {})
table.insert(winbar_components.active, {})
table.insert(winbar_components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(winbar_components.inactive, {})
table.insert(winbar_components.inactive, {})

table.insert(winbar_components.active[1], {
  provider = function()
    local columns = vim.api.nvim_get_option("columns")
    if not pcall(require, "lsp_signature") then
      return treesitter_context(columns)
    end
    local sig = require("lsp_signature").status_line(columns)

    if sig == nil or sig.label == nil or sig.range == nil then
      return treesitter_context(columns)
    end
    local label1 = sig.label
    local label2 = ""
    if sig.range then
      label1 = sig.label:sub(1, sig.range["start"] - 1)
      label2 = sig.label:sub(sig.range["end"] + 1, #sig.label)
    end
    local doc = sig.doc or ""
    if #doc + #sig.label >= columns then
      local trim = math.max(5, columns - #sig.label - #sig.hint - 10)
      doc = doc:sub(1, trim) .. "..."
      -- lprint(doc)
    end


    return "%#WinBarSignature#"
        .. label1
        .. "%*"
        .. "%#WinBarSigActParm#"
        .. sig.hint
        .. "%*"
        .. "%#WinBarSignature#"
        .. label2
        .. "%*"
        .. "%#WinBarSigDoc#"
        .. " " .. doc
        or "" .. "%*"
  end
})

local winbar_force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {},
}

winbar_force_inactive.filetypes = {
  "NvimTree",
  "neo-tree",
  "startify",
  "alpha",
  "fugitive",
  "fugitiveblame",
}

winbar_force_inactive.buftypes = {
  "terminal",
}

winbar_force_inactive.bufnames = {
  "[No Name]",
  "No Name",
}

require("feline").winbar.setup({
  -- components = winbar_components, -- comment for simple filename
  force_inactive = winbar_force_inactive,
})

return M
