local wezterm = require('wezterm')
local palette = dofile('~/templates/palette.lua')
local config = {}

config.colors = {
  foreground = palette.palette.main[7],
  background = '#21201a',
  cursor_bg = '#e6c68a',
  cursor_border = '#e6c68a',
  cursor_fg = '#21201a',
  ansi = {
    '#21201a',
    '#ff2121',
    '#529d51',
    '#d6d054',
    '#7abcf5',
    '#ff79c6',
    '#87dfdf',
    '#e6c68a'
  },
  brights = {
    '#302F27',
    '#fb6767',
    '#88c288',
    '#e6f074',
    '#90d9ff',
    '#ffb1d9',
    '#99ffff',
    '#d5e6e6'
  }
}

config.font_size = 16.6
config.font = wezterm.font('Monaspace Xenon Var', {weight=400, italic = false})
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font('Monaspace Neon Var', {weight=1300}),
  },
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font('Monaspace Radon Var', {weight=400, italic=false})
  },
  {
    intensity = 'Normal',
    italic = false,
    font = wezterm.font('Monaspace Neon Var', {weight=400, italic=false})
  }
}

config.harfbuzz_features = {
  'calt=1',
  'dlig=1',
  'ss01=1',
  'ss02=1',
  'ss03=1',
  'ss04=1',
  'ss05=1',
  'ss06=1',
  'ss07=1',
  'ss08=1',
}

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

return config
