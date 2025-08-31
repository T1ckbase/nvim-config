vim.cmd.colorscheme('retrobox') -- habamax, retrobox, zenbones

vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = nil })
-- vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#484848' })
-- vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#000000' })

vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#e45454' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#ff942f' })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#00b7e4' })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#2faf64' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { underline = false, undercurl = true, sp = '#e45454' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { underline = false, undercurl = true, sp = '#ff942f' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { underline = false, undercurl = true, sp = '#00b7e4' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = false, undercurl = true, sp = '#2faf64' })
