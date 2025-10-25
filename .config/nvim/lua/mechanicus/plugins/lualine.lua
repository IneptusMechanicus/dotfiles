return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'IneptusMechanicus/mechanicus.nvim'},
  config = function()
    local palette = require('mechanicus.colorscheme').palette
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = {bg = palette.ansi7, fg = palette.ansi_bg, gui = 'bold'},
            b = {bg = palette.ansi2, fg = palette.ansi_bg},
            c = {bg = palette.ansi_bg, fg = palette.ansi7}
          },
          insert = {
            a = {bg = palette.ansi10, fg = palette.ansi_bg, gui = 'bold'},
            b = {bg = palette.ansi2, fg = palette.ansi_bg},
            c = {bg = palette.ansi_bg, fg = palette.ansi7}
          },
          visual = {
            a = {bg = palette.ansi3, fg = palette.ansi_bg, gui = 'bold'},
            b = {bg = palette.ansi2, fg = palette.ansi_bg},
            c = {bg = palette.ansi_bg, fg = palette.ansi7}
          },
          command = {
            a = {bg = palette.ansi12, fg = palette.ansi_bg, gui = 'bold'},
            b = {bg = palette.ansi2, fg = palette.ansi_bg},
            c = {bg = palette.ansi_bg, fg = palette.ansi7}
          }
        },
        component_separators = '|',
        section_separators = ' ',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    })
  end
}
