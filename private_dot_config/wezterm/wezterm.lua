-- set this to true to enable the retro style tab bar and display workspace and stuff.
-- Try it! it's not for me, but I wanna leave it in here in case I change my mind.
local extrastuff = true

local wezterm = require("wezterm")
local config = wezterm.config_builder()
require("keys").setup(config)
-- new stuff (mostly from https://github.com/theopn/dotfiles/blob/ea71900c0d70885c87b30ef056795316f6d3abae/wezterm/wezterm.lua#L27)
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.default_cursor_style = "BlinkingBar"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.command_palette_font_size = 14
config.command_palette_bg_color = "#313244"
config.command_palette_fg_color = "#bac2de"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.kde_window_background_blur = true
config.window_decorations = "RESIZE"
config.enable_wayland = false

config.window_background_gradient = {
    orientation = "Vertical",
    colors = {
        "#000000",
        "#1e1e2e",
    },
}
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5,
}

config.color_scheme = "Catppuccin Mocha"
config.front_end = "WebGpu"
config.font_dirs = { wezterm.home_dir .. "/.local/share/chezmoi/miscFiles/fonts" }
config.font = wezterm.font_with_fallback{ "Ioskeley Mono" }
config.warn_about_missing_glyphs = false
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true
config.cursor_blink_rate = 1000

if wezterm.target_triple == "aarch64-apple-darwin" then
    config.default_prog = { "/opt/homebrew/bin/fish/", "-l" }
else
    config.default_prog = { "fish" }
    config.max_fps = 120
end

-- Extra stuff from https://github.com/theopn/dotfiles/blob/ea71900c0d70885c87b30ef056795316f6d3abae/wezterm/wezterm.lua#L27.
if extrastuff then
    config.hide_tab_bar_if_only_one_tab = false
    config.use_fancy_tab_bar = false
    wezterm.on("update-status", function(window, pane)
        -- Workspace name
        local stat = window:active_workspace()
        local stat_color = "#f7768e"
        -- It's a little silly to have workspace name all the time
        -- Utilize this to display LDR or current key table name
        if window:active_key_table() then
            stat = window:active_key_table()
            stat_color = "#7dcfff"
        end
        if window:leader_is_active() then
            stat = "LDR"
            stat_color = "#bb9af7"
        end

        local basename = function(s)
            -- Nothing a little regex can't fix
            return string.gsub(s, "(.*[/\\])(.*)", "%2")
        end

        -- Current working directory
        local cwd = pane:get_current_working_dir()
        if cwd then
            if type(cwd) == "userdata" then
                -- Wezterm introduced the URL object in 20240127-113634-bbcac864
                cwd = basename(cwd.file_path)
            else
                -- 20230712-072601-f4abf8fd or earlier version
                cwd = basename(cwd)
            end
        else
            cwd = ""
        end

        -- Current command
        local cmd = pane:get_foreground_process_name()
        -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
        cmd = cmd and basename(cmd) or ""

        -- Time
        local time = wezterm.strftime("%H:%M")

        -- Left status (left of the tab line)
        window:set_left_status(wezterm.format({
            { Foreground = { Color = stat_color } },
            { Text = "  " },
            { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
            { Text = " |" },
        }))

        -- Right status
        window:set_right_status(wezterm.format({
            -- Wezterm has a built-in nerd fonts
            -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
            { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
            { Text = " | " },
            { Foreground = { Color = "#e0af68" } },
            { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
            "ResetAttributes",
            { Text = " | " },
            { Text = wezterm.nerdfonts.md_clock .. "  " .. time },
            { Text = "  " },
        }))
    end)
end

return config
