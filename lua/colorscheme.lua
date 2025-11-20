vim.opt.rtp:append('C:\\Users\\Nah\\personal-files\\projects\\bleak.nvim')

vim.cmd.colorscheme('retrobox') -- habamax, retrobox,  vscode

vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#e45454' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#ff942f' })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#00b7e4' })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#2faf64' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false, undercurl = true, sp = '#e45454' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = false, undercurl = true, sp = '#ff942f' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false, undercurl = true, sp = '#00b7e4' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false, undercurl = true, sp = '#2faf64' })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = nil })

-- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#484848' })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#000000' })

vim.api.nvim_set_hl(0, 'Added', { fg = '#2ea043' })
vim.api.nvim_set_hl(0, 'Changed', { fg = '#0078d4' })
vim.api.nvim_set_hl(0, 'Removed', { fg = '#f85149' })

vim.api.nvim_set_hl(0, 'MiniDiffOverAdd', { bg = '#353f1f' })
vim.api.nvim_set_hl(0, 'MiniDiffOverDelete', { bg = '#491616' })
vim.api.nvim_set_hl(0, 'MiniDiffOverChange', { bg = '#721111' })
vim.api.nvim_set_hl(0, 'MiniDiffOverContext', { bg = '#491616' })
vim.api.nvim_set_hl(0, 'MiniDiffOverChangeBuf', { bg = '#485c29' })
vim.api.nvim_set_hl(0, 'MiniDiffOverContextBuf', { bg = '#353f1f' })

vim.api.nvim_set_hl(0, 'MiniTablineFill', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { link = 'MiniTablineCurrent' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { link = 'MiniTablineVisible' })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { link = 'MiniTablineHidden' })

vim.api.nvim_set_hl(0, 'MiniCursorword', { bg = '#252525', underline = false })
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#404040' })

if vim.g.colors_name == 'retrobox' then
  vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#4f665b' })
  vim.api.nvim_set_hl(0, 'PmenuKindSel', { bg = '#4f665b' })
  vim.api.nvim_set_hl(0, 'PmenuExtraSel', { bg = '#4f665b' })
  vim.api.nvim_set_hl(0, 'PmenuMatchSel', { bg = '#4f665b' })
  vim.api.nvim_set_hl(0, 'Visual', { bg = '#32403a' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', { fg = '#fe8019' })
  -- vim.api.nvim_set_hl(0, 'SnacksPicker', { link = 'Normal' })
  -- vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = '#807366' })
  -- vim.api.nvim_set_hl(0, 'SnacksPickerDir', { fg = 'NONE', bg = 'NONE', nocombine = true })
  -- vim.api.nvim_set_hl(0, 'SnacksPickerDirectory', { fg = 'NONE', bg = 'NONE', nocombine = true })
end

if vim.g.colors_name == 'vscode' then
  vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { bg = '#3d3d3d' })
  vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { link = 'MiniStatuslineFilename' })
  vim.api.nvim_set_hl(0, 'TabLine', { fg = '#868686', bg = '#101010' })
end
