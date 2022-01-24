require('nvim-autopairs').setup {
    map_cr = true,
    map_complete = true,
    auto_select = true,
    ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    check_ts = true,
    ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
    },
    disable_filetype = { 'TelescopePrompt', 'vim' },
}
