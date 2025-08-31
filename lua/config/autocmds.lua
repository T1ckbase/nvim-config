local group = vim.api.nvim_create_augroup('UserConfig', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 50 })
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    if vim.o.background ~= 'dark' then
      vim.schedule(function()
        vim.opt.background = 'dark'
      end)
    end
  end,
})

-- vim.api.nvim_create_autocmd('CmdlineEnter', {
--   group = group,
--   callback = function()
--     vim.o.cmdheight = 1
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--   group = group,
--   callback = function()
--     vim.o.cmdheight = 0
--   end,
-- })
