local augroup = vim.api.nvim_create_augroup('UserConfig', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 80 })
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    if vim.o.background ~= 'dark' then
      vim.opt.background = 'dark'
    end
  end,
})

vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = augroup,
  callback = function()
    vim.g.__saved_laststatus = vim.opt.laststatus:get()
    vim.opt.laststatus = 0
    vim.opt.cmdheight = 1
  end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = augroup,
  callback = function()
    if vim.g.__saved_laststatus ~= nil then
      vim.opt.laststatus = vim.g.__saved_laststatus
      vim.g.__saved_laststatus = nil
      vim.opt.cmdheight = 0
    end
  end,
})
