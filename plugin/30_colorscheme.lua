-- vim.cmd.colorscheme('custom')

vim.g.gruvbox_material_foreground = 'mix'
-- vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.cmd.colorscheme('gruvbox-material')

vim.api.nvim_set_hl(0, 'CurSearch', { link = 'Search' })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { undercurl = true, sp = '#626262' })
