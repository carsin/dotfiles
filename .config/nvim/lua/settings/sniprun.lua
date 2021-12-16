require'sniprun'.setup({
  --# you can combo different display modes as desired
  display = {
    "Classic",                    --# display results in the command-line  area
    "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)
    "VirtualTextErr",          --# display error results as virtual text
    -- "TempFloatingWindow",      --# display results in a floating window
    "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
    -- "Terminal",                --# display results in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin TODO: make this work
    -- "Api"                      --# return output to a programming interface
  },

  --# You can use the same keys to customize whether a sniprun producing
  --# no output should display nothing or '(no output)'
  -- show_no_output = {
    -- "Classic",
    -- "TempFloatingWindow",      --# implies LongTempFloatingWindow, which has no effect on its own
  -- },

  --# customize highlight groups (setting this overrides colorscheme)
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg=none,fg="#b8bb26", ctermbg=none},
    SniprunFloatingWinOk   =  {bg=none,fg="#ebdbb2", ctermbg=none},
    SniprunVirtualTextErr  =  {bg=none,fg="#fb4934"},
    SniprunFloatingWinErr  =  {bg=none,fg="#fb4934"},
  },
  borders = 'single'               --# display borders around floating windows
                                   --# possible values are 'none', 'single', 'double', or 'shadow'
})
