vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

vim.filetype.add({ pattern = { ['%.gitconfig%-.*'] = 'gitconfig' } })

vim.api.nvim_create_augroup('custom-config', {})
