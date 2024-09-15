local wezterm = require('wezterm')
local config = {}

config.colors = {
  foreground = palette.palette.main[7],
  background = os.getenv('COLOR_00'),
  cursor_bg = os.getenv('COLOR_07'),
  cursor_border = os.getenv('COLOR_07'),
  cursor_fg = os.getenv('COLOR_00'),
  ansi = {
    os.getenv('COLOR_00'),
    os.getenv('COLOR_01'),
    os.getenv('COLOR_02'),
    os.getenv('COLOR_03'),
    os.getenv('COLOR_04'),
    os.getenv('COLOR_05'),
    os.getenv('COLOR_06'),
    os.getenv('COLOR_07')
  },
  brights = {
    os.getenv('COLOR_08'),
    os.getenv('COLOR_09'),
    os.getenv('COLOR_10'),
    os.getenv('COLOR_11'),
    os.getenv('COLOR_12'),
    os.getenv('COLOR_13'),
    os.getenv('COLOR_14'),
    os.getenv('COLOR_15')
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
