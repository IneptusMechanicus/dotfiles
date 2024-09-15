local M = {}
local colorscheme_path = os.getenv('NVIM_COLORSCHEME_PATH')
if vim.fn.empty(vim.fn.glob(colorscheme_path)) > 0 then
  M = {'IneptusMechanicus/mechanicus.nvim'}
else
  M.dir = colorscheme_path
end

M.config = function()
  local termPalette = dofile(os.getenv('HOME') .. '/templates/palette.lua').palette
  require('mechanicus').setup({
    ansi0 = termPalette.main[1],
    ansi1 = termPalette.main[2],
    ansi2 = termPalette.main[3],
    ansi3 = termPalette.main[4],
    ansi4 = termPalette.main[5],
    ansi5 = termPalette.main[6],
    ansi6 = termPalette.main[7],
    ansi7 = termPalette.main[8],
    ansi8 = termPalette.bright[1],
    ansi9 = termPalette.bright[2],
    ansi10 = termPalette.bright[3],
    ansi11 = termPalette.bright[4],
    ansi12 = termPalette.bright[5],
    ansi13 = termPalette.bright[6],
    ansi14 = termPalette.bright[7],
    ansi15 = termPalette.bright[8]
  });
end

return M
