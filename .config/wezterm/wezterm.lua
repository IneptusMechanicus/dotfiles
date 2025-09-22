local wezterm = require('wezterm')
local palette = dofile(os.getenv('HOME')..'/.palette.lua').palette;
local config = {}

config.colors = {
  foreground = palette.main[9],
  background = palette.main[1],
  cursor_bg = palette.main[9],
  cursor_border = palette.main[9],
  cursor_fg = palette.main[1],
  ansi = palette.main,
  brights = palette.bright
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
