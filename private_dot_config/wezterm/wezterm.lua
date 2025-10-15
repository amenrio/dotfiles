local wezterm = require('wezterm')

local config = wezterm.config_builder()
config.default_prog = {'pwsh'}
-- config.default_prog = {'pwsh', "-NoLogo"}

config.font_size = 13
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")



--- Colors
-- config.colors = {
--     cursor_bg = "white",
--     cursor_border = "white",
-- }
config.color_scheme = "Tokyo Night"


--- Appearance
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 10,
    bottom = 0
}
config.window_background_opacity = 1

--- Misc settings
-- config.default_cwd = "C:\\Users\\Amenrio"
config.max_fps = 144
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "$HOME"
config.audible_bell = "Disabled"

--- Keys
---
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds=2000}
config.keys = {
    --- Tmux-like movement
    { key = "c", mods = "LEADER",       action = wezterm.action.SpawnTab "CurrentPaneDomain", },
    { key = "x", mods = "LEADER",       action = wezterm.action.CloseCurrentPane { confirm = true }, },
    { key = "b", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
    { key = "n", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
    { key = "-", mods = "LEADER",       action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain'} },
    { key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = "h", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "z", mods = "LEADER",       action = wezterm.action.TogglePaneZoomState},
    --- Key table for resize
    { key = "r", mods = "LEADER",       action = wezterm.action.ActivateKeyTable { name = "resize_pane", one_shot = false}},

    -- { key = "s", mods = "LEADER",       action = wezterm.action.RotatePanes "Clockwise"},
    { key = "t", mods = "LEADER",       action = wezterm.action.ShowTabNavigator },

    { key = "m", mods = "LEADER",       action = wezterm.action.ActivateKeyTable { name = "move_tab", one_shot = false}},
    { key = "p", mods = "LEADER",       action = wezterm.action.PaneSelect {mode = "SwapWithActive"}},
    --- Rename tabs
    { key = ',', mods = 'LEADER', action = wezterm.action.PromptInputLine { 
        description = 'Enter new name for tab',
          action = wezterm.action_callback(function(window, pane, line)
            if line then
              window:active_tab():set_title(line)
            end
          end),
    },
  },
    {
        key = '.',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = "s",
        mods = "LEADER",
        action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" },
    },


}

config.key_tables = {
    move_tab = {
        {key = "h", action = wezterm.action.MoveTabRelative(-1)},
        {key = "j", action = wezterm.action.MoveTabRelative(-1)},
        {key = "k", action = wezterm.action.MoveTabRelative(1)},
        {key = "l", action = wezterm.action.MoveTabRelative(1)},
        {key = "Escape", action = "PopKeyTable"},
        {key = "Enter", action = "PopKeyTable"},
    },
    resize_pane = {
        {key = "LeftArrow", action = wezterm.action.AdjustPaneSize { "Left", 5 }},

        {key = "DownArrow", action = wezterm.action.AdjustPaneSize { "Down", 5 }},
        {key = "UpArrow", action = wezterm.action.AdjustPaneSize { "Up", 5 }},
        {key = "RightArrow", action = wezterm.action.AdjustPaneSize { "Right", 5 }},
        {key = "h", action = wezterm.action.AdjustPaneSize { "Left", 1 }},
        {key = "j", action = wezterm.action.AdjustPaneSize { "Down", 1 }},
        {key = "k", action = wezterm.action.AdjustPaneSize { "Up", 1 }},
        {key = "l", action = wezterm.action.AdjustPaneSize { "Right", 1 }},
        {key = "Escape", action = "PopKeyTable"},
        {key = "Enter", action = "PopKeyTable"},
    }
}

config.launch_menu = {
    {
        label = "Ubuntu",
        args = { "wsl" , "-d", "Ubuntu"},
    },
    {
        args = { "ls" }
    }
}

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

return config

