local M = {}

M.palette = {
  ansi0       = os.getenv('COLOR_00'),
  ansi1       = os.getenv('COLOR_01'),
  ansi2       = os.getenv('COLOR_02'),
  ansi3       = os.getenv('COLOR_03'),
  ansi4       = os.getenv('COLOR_04'),
  ansi5       = os.getenv('COLOR_05'),
  ansi6       = os.getenv('COLOR_06'),
  ansi7       = os.getenv('COLOR_07'),
  ansi8       = os.getenv('COLOR_08'),
  ansi9       = os.getenv('COLOR_09'),
  ansi10      = os.getenv('COLOR_10'),
  ansi11      = os.getenv('COLOR_11'),
  ansi12      = os.getenv('COLOR_12'),
  ansi13      = os.getenv('COLOR_13'),
  ansi14      = os.getenv('COLOR_14'),
  ansi15      = os.getenv('COLOR_15'),
  base0       = '#1a1a17',
  base1       = '#302F27',
  base2       = '#3C3A2E',
  base3       = '#424033',
  base4       = '#54534d',
  base5       = '#9ca0a4',
  base6       = '#b1b1b1',
  base7       = '#e3e3e1',
  diff_add    = '#77a66c',
  diff_remove = '#ef6831',
  diff_change = '#27407f',
  diff_text   = '#d6d054',
}

M.hi_treesitter = function(palette)
  return {
    keyword = { fg = palette.ansi4, style = 'italic' },
    comment = { fg = palette.base4, style = 'italic' },
    builtin_consts = { fg = palette.ansi13, style = 'italic' },
    consts = { fg = palette.ansi12, style = 'bold' },
    strings = { fg = palette.ansi2, style = 'italic' },
    entity = { fg = palette.ansi11, style = 'bold'},
    variable = { fg = palette.ansi9 },
    property = { fg = palette.ansi7, style ='italic' },
    parameter = { fg = palette.lightansi9, style = 'italic' },
    punctuation = { fg = palette.ansi6, style = 'bold' },
    parentheses = { fg = palette.ansi8, style = 'bold' },
    functions = { fg = palette.ansi10, style = 'bold' },
    types = { fg = palette.base6, style = 'italic' },
    namespaces = { fg = palette.ansi10, style = 'italic' },
  }
end

M.highlight_group = function(palette, treesitter)
  return {
    -- Base --
    Normal = { fg = palette.ansi7, bg = palette.ansi0 },
    NormalFloat = { bg = palette.base1 },
    NonText = { fg = palette.base2 },
    Visual = { bg = palette.base3 },
    VisualNOS = { bg = palette.base2 },
    Search = { fg = palette.ansi0, bg = palette.ansi3 },
    IncSearch = { fg = palette.ansi0, bg = palette.ansi9 },
    MatchParen = { fg = palette.ansi9 },
    Question = { fg = palette.ansi3 },
    ModeMsg = { fg = palette.ansi7, style = 'bold' },
    MoreMsg = { fg = palette.ansi7, style = 'bold' },
    ErrorMsg = { fg = palette.ansi1, style = 'bold' },
    WarningMsg = { fg = palette.ansi3, style = 'bold' },
    VertSplit = { fg = palette.ansi6 },
    LineNr = { fg = palette.base4, bg = palette.base0 },
    Cursor = { style = 'reverse' },
    CursorLine = { bg = palette.ansi0 },
    CursorLineNr = { fg = palette.base6, bg = palette.base1, style = 'bold' },
    CursorLineSign = { fg = palette.base6, bg = palette.base1 },
    SignColumn = { bg = palette.base0 },
    ColorColumn = { bg = palette.base1 },
    SpellBad = { fg = palette.ansi1, style = 'undercurl' },
    SpellCap = { fg = palette.ansi5, style = 'undercurl' },
    SpellRare = { fg = palette.ansi4, style = 'undercurl' },
    SpellLocal = { fg = palette.ansi9, style = 'undercurl' },
    SpecialKey = { fg = palette.ansi9 },
    Special = { fg = palette.ansi3 },
    Title = { fg = palette.ansi11, style = 'bold' },
    Identifier = { fg = palette.ansi4, style = 'bold' },

    -- Git colors --
    DiffAdd = { bg = palette.diff_add },
    DiffDelete = { bg = palette.diff_remove },
    DiffChange = { bg = palette.diff_change },
    DiffText = { bg = palette.diff_text },
    diffAdded = { fg = palette.ansi10 },
    diffRemoved = { fg = palette.ansi1 },

    -- Popups --
    Pmenu = { fg = palette.ansi7, bg = palette.base2 },
    PmenuSel = { fg = palette.base3, bg = palette.ansi7 },
    PmenuSelBold = { fg = palette.base3, bg = palette.ansi9 },
    PmenuThumb = { fg = palette.ansi5, bg = palette.ansi10 },
    PmenuSbar = { bg = palette.base2 },
    String = { fg = palette.ansi10, style = 'italic' },
    dbui_tables = { fg = palette.ansi7 },

    -- Diagnostics --
    DiagnosticSignError = {fg = palette.ansi1 },
    DiagnosticSignWarn = { fg = palette.ansi3 },
    DiagnosticSignInfo = { fg = palette.ansi7 },
    DiagnosticSignHint = { fg = palette.ansi4 },
    DiagnosticVirtualTextError = { fg = palette.ansi1 },
    DiagnosticVirtualTextWarn = { fg = palette.ansi3 },
    DiagnosticVirtualTextInfo = { fg = palette.ansi7 },
    DiagnosticVirtualTextHint = { fg = palette.ansi4 },
    DiagnosticUnderlineError = { style = 'undercurl', sp = palette.ansi1 },
    DiagnosticUnderlineWarn = { style = 'undercurl', sp = palette.ansi3 },
    DiagnosticUnderlineInfo = { style = 'undercurl', sp = palette.ansi7 },
    DiagnosticUnderlineHint = { style = 'undercurl', sp = palette.ansi4 },
    DiagnosticError = { style = 'undercurl', sp = palette.ansi1 },
    DiagnosticWarn = { style = 'undercurl', sp = palette.ansi3 },
    DiagnosticInfo = { style = 'undercurl', sp = palette.ansi7 },
    DiagnosticHint = { style = 'undercurl', sp = palette.ansi4 },

    -- hrsh7th/nvim-cmp
    CmpDocumentation = { fg = palette.ansi7, bg = palette.base1 },
    CmpDocumentationBorder = { fg = palette.ansi7, bg = palette.base1 },
    CmpItemAbbr = { fg = palette.ansi7 },
    CmpItemAbbrMatch = { fg = palette.ansi4 },
    CmpItemAbbrMatchFuzzy = { fg = palette.ansi4 },
    CmpItemKindDefault = { fg = palette.ansi7 },
    CmpItemMenu = { fg = palette.base5 },
    CmpItemKindKeyword = { fg = palette.ansi9 },
    CmpItemKindVariable = { fg = palette.ansi9 },
    CmpItemKindConstant = { fg = palette.ansi9 },
    CmpItemKindReference = { fg = palette.ansi9 },
    CmpItemKindValue = { fg = palette.ansi9 },
    CmpItemKindFunction = { fg = palette.ansi4 },
    CmpItemKindMethod = { fg = palette.ansi4 },
    CmpItemKindConstructor = { fg = palette.ansi4 },
    CmpItemKindClass = { fg = palette.ansi9 },
    CmpItemKindInterface = { fg = palette.ansi9 },
    CmpItemKindStruct = { fg = palette.ansi9 },
    CmpItemKindEvent = { fg = palette.ansi9 },
    CmpItemKindEnum = { fg = palette.ansi9 },
    CmpItemKindUnit = { fg = palette.ansi9 },
    CmpItemKindModule = { fg = palette.ansi3 },
    CmpItemKindProperty = { fg = palette.ansi10 },
    CmpItemKindField = { fg = palette.ansi10 },
    CmpItemKindTypeParameter = { fg = palette.ansi10 },
    CmpItemKindEnumMember = { fg = palette.ansi10 },
    CmpItemKindOperator = { fg = palette.ansi10 },

    -- WhichKey
    WhichKey = {fg = palette.ansi10, style = 'bold'},
    WhichKeyFloat = {fg = palette.ansi7, bg = palette.ansi0},
    WhichKeyGroup = {fg = palette.ansi9, style = 'italic'},
    WhichKeySeparator = {fg = palette.ansi3, style = 'bold'},
    WhichKeyDesc = {fg = palette.ansi4, style = 'italic'},

    -- Telescope --
    TelescopeBorder = { fg = palette.ansi10 },
    TelescopePreviewRead = { fg = palette.ansi2},
    TelescopePreviewWrite = { fg = palette.ansi4 },
    TelescopePreviewExecute = { fg = palette.ansi7, style = 'bold' },
    TelescopePreviewDirectory = { fg = palette.base6, style = 'italic' },
    TelescopePreviewSize = { fg = palette.ansi5, style = 'italic' },
    TelescopePreviewUser = { fg = palette.ansi2, style = 'italic' },
    TelescopePreviewGroup = { fg = palette.ansi10, style = 'italic' },
    TelescopePreviewDate = { fg = palette.base5, style = 'italic' },
    TelescopePreviewTitle = { fg = palette.ansi3, style = 'bold' },
    TelescopePrompt = { fg = palette.ansi4 },
    TelescopePromptBorder = { fg = palette.ansi9 },
    TelescopePromptTitle = { fg = palette.ansi3, style = 'bold' },
    TelescopeResultsTitle = { fg = palette.ansi3, style = 'bold' },
    TelescopeResultsBorder = { fg = palette.ansi4 },

    -- Treesitter --
    ['@string'] = treesitter.strings,
    ['@character'] = treesitter.strings,
    ['@boolean'] = treesitter.builtin_consts,
    ['@number'] = treesitter.builtin_consts,
    ['@number.float'] = treesitter.builtin_consts,
    ['@string.escape'] = treesitter.builtin_consts,
    ['@comment'] = treesitter.comment,
    ['@property'] = treesitter.property,
    ['@constant'] = treesitter.consts,
    ['@constant.builtin'] = treesitter.builtin_consts,
    ['@variable'] = treesitter.variable,
    ['@variable.member'] = treesitter.property,
    ['@variable.builtin'] = treesitter.consts,
    ['@variable.parameter'] = treesitter.parameter,
    --
    ['@keyword'] = treesitter.keyword,
    ['@keyword.import'] = treesitter.keyword,
    ['@keyword.repeat'] = treesitter.keyword,
    ['@keyword.function'] = treesitter.types,
    ['@keyword.operator'] = treesitter.punctuation,
    ['@keyword.exception'] = treesitter.keyword,
    ['@keyword.conditional'] = treesitter.keyword,
    ['@keyword.conditional.ternary'] = treesitter.entity,
    --
    ['@module'] = treesitter.namespaces,
    ['@storageclass'] = treesitter.types,
    --
    ['@function'] = treesitter.functions,
    ['@function.call'] = treesitter.functions,
    ['@function.macro'] = treesitter.namespaces,
    ['@function.method'] = treesitter.functions,
    ['@function.method.call'] = treesitter.functions,
    ['@function.builtin'] = treesitter.functions,
    ['@operator'] = treesitter.punctuation,
    ['@constructor'] = treesitter.entity,
    --
    ['@punctuation.bracket'] = treesitter.parentheses,
    ['@punctuation.special'] = treesitter.parentheses,
    ['@punctuation.delimiter'] = treesitter.punctuation,
    --
    ['@tag'] = treesitter.entity,
    ['@tag.attribute'] = treesitter.variable,
    ['@tag.delimiter'] = treesitter.parentheses,
    ['@type'] = treesitter.entity,
    ['@type.builtin'] = treesitter.types,
    ['@type.qualifier'] = treesitter.keyword,
    ['@type.definition'] = treesitter.functions,
    ['@label'] = { fg = palette.ansi9, style = 'italic' },

    -- LSP Semantic Tokens --

    ['@lsp.type.comment'] = treesitter.comment,
    ['@lsp.type.enum'] = treesitter.entity,
    ['@lsp.type.enumMember'] = treesitter.variable,
    ['@lsp.type.property'] = treesitter.variable,
    ['@lsp.type.interface'] = treesitter.entity,
    ['@lsp.type.class'] = treesitter.entity,
    ['@lsp.type.type'] = treesitter.entity,
    ['@lsp.type.variable'] = treesitter.variable,
    ['@lsp.type.namespace'] = treesitter.namespaces,
    ['@lsp.type.function'] = treesitter.functions,
    ['@lsp.type.decorator'] = treesitter.functions,
    ['@lsp.type.method'] = treesitter.functions,
    ['@lsp.type.parameter'] = treesitter.parameter
  }
end

M.setup = function()
  local theme = M.highlight_group(M.palette, M.hi_treesitter(M.palette))

  vim.cmd.hi('clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
  end

  vim.o.background = 'dark'
  vim.o.termguicolors = true
  vim.g.colors_name = M.palette.name

  for group, color in pairs(theme) do
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg = ' .. color.fg or 'guifg = NONE'
    local bg = color.bg and 'guibg = ' .. color.bg or 'guibg = NONE'
    local sp = color.sp and 'guisp = ' .. color.sp or 'guisp = NONE'
    vim.cmd.highlight(group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp)
  end
end

return M
