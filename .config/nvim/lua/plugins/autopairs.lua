require('nvim-autopairs').setup{
    map_cr = true,
    map_complete = true,
    auto_select = true,
    check_ts = true,
    ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
    },
    disable_filetype = { 'TelescopePrompt', 'vim' },
}
