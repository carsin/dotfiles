local wezterm = require "wezterm"
local scrollback_lines = 20000;
local home = wezterm.home_dir;

wezterm.add_to_config_reload_watch_list(home .. "/.cache/wal/wezterm-wal.toml");

return {
    color_scheme_dirs = { home .. "/.cache/wal" },
    color_scheme = "wezterm-wal",
    font_size = 10.0,
    font = wezterm.font_with_fallback({ "Terminus", "Nerd Font Complete" }),
    skip_close_confirmation_for_processes_named = {
        "zsh", "bash", "sh", "fish", "tmux"
    },
    alternate_buffer_wheel_scroll_speed = 5,
    window_background_opacity = 0.85,
    text_background_opacity = 1.0,
    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4
    },
    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 430,
    cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } },
    cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 0.0, 0.0 } },
    -- hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = scrollback_lines,
    use_fancy_tab_bar = false,
    automatically_reload_config = true,
    use_resize_increments = false,
    adjust_window_size_when_changing_font_size = false,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    check_for_updates = false,
    hyperlink_rules = {
        -- Linkify things that look like URLs
        -- This is actually the default if you don't specify any hyperlink_rules
        {
            regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
            format = "$0",
        },

        -- linkify email addresses
        {
            regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
            format = "mailto:$0",
        },

        -- file:// URI
        {
            regex = "\\bfile://\\S*\\b",
            format = "$0",
        },
    },
    leader = { key = "n", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
        --       {key = "a", mods = "LEADER|CTRL", action = wezterm.action {SendString = "\x01"}},
        --       {key = "u", mods = "LEADER", action = wezterm.action {SendString = "wask up\x0D "}},
        --       {key = "r", mods = "LEADER", action = wezterm.action {SendString = "historyfzf\x0D "}},
        --       {key = "e", mods = "LEADER", action = wezterm.action {SendString = "code .\x0D "}},
        --       {key = "ä", mods = "LEADER", action = wezterm.action {SendString = "alert $(echo $nu.env | get ALERT)\x0D "}},
        --       {key = "f", mods = "LEADER", action = wezterm.action {Search = {CaseInSensitiveString = ""}}},
        --       {key = "n", mods = "LEADER", action = wezterm.action {SpawnTab = "CurrentPaneDomain"}},
        --       {key = "H", mods = "LEADER", action = wezterm.action {Search = {Regex = "[a-f0-9]{6,}"}}},
        --       {key = "C", mods = "LEADER", action = wezterm.action {CloseCurrentTab = {confirm = true}}},
        --       {key = "Enter", mods = "ALT|SHIFT", action = wezterm.action {SpawnTab = "CurrentPaneDomain"}},
        --       {key = "PageUp", mods = "SHIFT", action = wezterm.action {ScrollByPage = -1}},
        --       {key = "PageDown", mods = "SHIFT", action = wezterm.action {ScrollByPage = 1}},
        --       {key = "l", mods = "LEADER", action = "ShowLauncher"},
        --       {key = "N", mods = "LEADER", action = "ShowTabNavigator"},
        --       --
        --       {key = "f", mods = "LEADER", action = "TogglePaneZoomState"},
        --       {key = "v", mods = "LEADER", action = wezterm.action {SplitVertical = {domain = "CurrentPaneDomain"}}},
        --       {key = "h", mods = "LEADER", action = wezterm.action {SplitHorizontal = {domain = "CurrentPaneDomain"}}},
        --       {key = "c", mods = "LEADER", action = wezterm.action {CloseCurrentPane = {confirm = false}}},
        --       {key = "C", mods = "ALT", action = wezterm.action {CloseCurrentPane = {confirm = false}}},
        --       --
        --       {key = "RightArrow", mods = "ALT", action = wezterm.action {ActivatePaneDirection = "Right"}},
        --       {key = "LeftArrow", mods = "ALT", action = wezterm.action {ActivatePaneDirection = "Left"}},
        --       {key = "UpArrow", mods = "ALT", action = wezterm.action {ActivatePaneDirection = "Up"}},
        --       {key = "DownArrow", mods = "ALT", action = wezterm.action {ActivatePaneDirection = "Down"}},
        --       --
        --       {key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action {AdjustPaneSize = {"Right", 5}}},
        --       {key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action {AdjustPaneSize = {"Left", 5}}},
        --       {key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action {AdjustPaneSize = {"Up", 5}}},
        --       {key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action {AdjustPaneSize = {"Down", 5}}},
        --       --
        --       {key = "1", mods = "LEADER", action = wezterm.action {ActivateTab = 0}},
        --       {key = "2", mods = "LEADER", action = wezterm.action {ActivateTab = 1}},
        --       {key = "3", mods = "LEADER", action = wezterm.action {ActivateTab = 2}},
        --       {key = "4", mods = "LEADER", action = wezterm.action {ActivateTab = 3}},
        --       {key = "5", mods = "LEADER", action = wezterm.action {ActivateTab = 4}},
        --       {key = "m", mods = "LEADER", action = "Hide"},
        --       {key = "DownArrow", mods = "LEADER", action = "Hide"},
        -- {key = "r", mods = "LEADER", action = "ResetFontAndWindowSize"},
        --       --
        --       {key = "K", mods = "LEADER", action = wezterm.action {ClearScrollback = "ScrollbackOnly"}},
        --       {key = "k", mods = "LEADER", action = wezterm.action {ScrollToPrompt = 1}},
        --       {key = "j", mods = "LEADER", action = wezterm.action {ScrollToPrompt = -1}},
        --       {key = "UpArrow", mods = "LEADER", action = wezterm.action {ScrollByLine = -1}},
        --       {key = "DownArrow", mods = "LEADER", action = wezterm.action {ScrollByLine = 1}},
        --       --
        --       {key = "p", mods = "LEADER", action = wezterm.action {EmitEvent = "trigger-nvim-with-scrollback"}},
        -- {key = "e", mods = "LEADER", action = wezterm.action {EmitEvent = "plumb-selection"}},
        -- {key = "o", mods="LEADER", action = "ActivateLastTab" },
    },
    term = 'wezterm',
}
