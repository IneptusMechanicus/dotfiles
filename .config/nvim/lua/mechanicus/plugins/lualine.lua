return {
  'nvim-lualine/lualine.nvim',
  dependencies = {'IneptusMechanicus/mechanicus.nvim'},
  config = function()
    local palette = dofile(os.getenv('HOME')..'/templates/palette.lua').palette
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = {bg = palette.main[8], fg = palette.main[1], gui = 'bold'},
            b = {bg = palette.main[9], fg = palette.main[8]},
            c = {bg = palette.main[1], fg = palette.main[8]}
          },
          insert = {
            a = {bg = palette.main[3], fg = palette.main[1], gui = 'bold'},
            b = {bg = palette.main[9], fg = palette.main[8]},
            c = {bg = palette.main[1], fg = palette.main[8]}
          },
          visual = {
            a = {bg = palette.main[4], fg = palette.main[1], gui = 'bold'},
            b = {bg = palette.main[9], fg = palette.main[8]},
            c = {bg = palette.main[1], fg = palette.main[8]}
          },
          command = {
            a = {bg = palette.main[5], fg = palette.main[1], gui = 'bold'},
            b = {bg = palette.main[9], fg = palette.main[8]},
            c = {bg = palette.main[1], fg = palette.main[8]}
          }
        },
        component_separators = '|',
        section_separators = ' ',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {{
          'filename',
          path = 1
        }},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    })
  end
}
