vim.cmd.highlight('clear')

vim.g.colors_name = 'custom'


vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#1c1c1c' })
vim.api.nvim_set_hl(0, 'CurSearch', { link = 'Search' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1c1c1c' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#626262' })
vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#303030' })
vim.api.nvim_set_hl(0, 'MsgArea', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'Normal', { fg = '#c6c6c6', bg = '#121212' })
vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#c6c6c6', bg = '#303030' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#303030' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#585858' })
vim.api.nvim_set_hl(0, 'Search', { bg = '#875f00' })
vim.api.nvim_set_hl(0, 'Special', { fg = '#e4e4e4' })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#c6c6c6', bg = '#303030' })

-- vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#303030' })


vim.api.nvim_set_hl(0, 'Comment', { fg = '#626262', italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#808080' })
vim.api.nvim_set_hl(0, '@constant', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = '#949494' })
vim.api.nvim_set_hl(0, '@constructor', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#949494' })
vim.api.nvim_set_hl(0, 'Function', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@function.builtin', { link = 'Function' })
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#808080', italic = true })
vim.api.nvim_set_hl(0, 'Operator', { fg = '#808080' })
vim.api.nvim_set_hl(0, '@punctuation.special', { fg = '#808080' })
vim.api.nvim_set_hl(0, 'String', { fg = '#87afd7' })
vim.api.nvim_set_hl(0, '@string.escape', { fg = '#d7af87' })
vim.api.nvim_set_hl(0, '@string.regexp', { fg = '#949494' })
vim.api.nvim_set_hl(0, 'Tag', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@tag.builtin', { link = 'Tag' })
vim.api.nvim_set_hl(0, '@tag.delimiter', { link = 'Delimiter' })
vim.api.nvim_set_hl(0, 'Type', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@variable', { fg = '#c6c6c6' })
vim.api.nvim_set_hl(0, '@variable.builtin', { fg = '#c6c6c6' })



vim.api.nvim_set_hl(0, 'Added', { fg = '#5faf5f' })
vim.api.nvim_set_hl(0, 'Changed', { fg = '#0087ff' })
vim.api.nvim_set_hl(0, 'Removed', { fg = '#ff5f5f' })


vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#ffafaf' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#ffd787' })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#afd7ff' })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#afffd7' })
vim.api.nvim_set_hl(0, 'DiagnosticOk', { fg = '#87ffaf' })

vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { undercurl = true, sp = '#626262' })

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false, undercurl = true, sp = '#ffafaf' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = true, undercurl = true, sp = '#ffd787' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false, undercurl = true, sp = '#afd7ff' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false, undercurl = true, sp = '#afffd7' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineOk', { underline = false, undercurl = true, sp = '#87ffaf' })


vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = '#262626', underline = false })

vim.api.nvim_set_hl(0, 'MiniTablineFill', { bg = '#000000' })
