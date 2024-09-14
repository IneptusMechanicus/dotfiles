local M = {}
local colorscheme_path = os.getenv('NVIM_COLORSCHEME_PATH')
if vim.fn.empty(vim.fn.glob(colorscheme_path)) > 0 then
  M = {'IneptusMechanicus/mechanicus.nvim'}
else
  M.dir = colorscheme_path
end

M.config = function()
  local nvimColorscheme = require('mechanicus');
  local termColorscheme = dofile(os.getenv('HOME') .. '/templates/palette.lua')
  nvimColorscheme.palette.ansi0 = termColorscheme.palette.main[1]
  nvimColorscheme.palette.ansi1 = termColorscheme.palette.main[2]
  nvimColorscheme.palette.ansi2 = termColorscheme.palette.main[3]
  nvimColorscheme.palette.ansi3 = termColorscheme.palette.main[4]
  nvimColorscheme.palette.ansi4 = termColorscheme.palette.main[5]
  nvimColorscheme.palette.ansi5 = termColorscheme.palette.main[6]
  nvimColorscheme.palette.ansi6 = termColorscheme.palette.main[7]
  nvimColorscheme.palette.ansi7 = termColorscheme.palette.main[8]
  nvimColorscheme.palette.ansi8 = termColorscheme.palette.bright[1]
  nvimColorscheme.palette.ansi9 = termColorscheme.palette.bright[2]
  nvimColorscheme.palette.ansi10 = termColorscheme.palette.bright[3]
  nvimColorscheme.palette.ansi11 = termColorscheme.palette.bright[4]
  nvimColorscheme.palette.ansi12 = termColorscheme.palette.bright[5]
  nvimColorscheme.palette.ansi13 = termColorscheme.palette.bright[6]
  nvimColorscheme.palette.ansi14 = termColorscheme.palette.bright[7]
  nvimColorscheme.palette.ansi15 = termColorscheme.palette.bright[8]
  nvimColorscheme.setup();
end

return M
