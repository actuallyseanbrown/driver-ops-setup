-- Sean driver-ops rice — merge into ~/.wezterm.lua on Windows
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu'
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback({ 'JetBrainsMono Nerd Font', 'Cascadia Code', 'Consolas' })
config.font_size = 11.0
config.scrollback_lines = 20000
config.window_padding = { left = 6, right = 6, top = 4, bottom = 4 }

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'd', mods = 'LEADER', action = wezterm.action.SendString 'cd ~/driver-ops && yazi\n' },
  { key = 'n', mods = 'LEADER', action = wezterm.action.SendString 'cd ~/driver-ops && nvim .\n' },
  { key = 'c', mods = 'LEADER', action = wezterm.action.SendString 'cd ~/driver-ops && claude\n' },
}

return config
