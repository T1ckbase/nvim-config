local augroup = vim.api.nvim_create_augroup('UserConfig', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.hl.on_yank({ timeout = 80 })
  end,
})

vim.api.nvim_create_autocmd('OptionSet', {
  group = augroup,
  pattern = 'background',
  callback = function()
    if vim.o.background ~= 'dark' then
      vim.opt.background = 'dark'
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  group = augroup,
  pattern = 'MiniFilesWindowOpen',
  callback = function(args)
    local win_id = args.data.win_id
    local config = vim.api.nvim_win_get_config(win_id)
    config.border = 'single'
    vim.api.nvim_win_set_config(win_id, config)
  end,
})

vim.api.nvim_create_autocmd('User', {
  group = augroup,
  pattern = 'MiniFilesActionRename',
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

-- vim.api.nvim_create_autocmd('VimLeave', {
--   group = vim.api.nvim_create_augroup('mini_sessions_auto_save', {}),
--   pattern = '*',
--   desc = 'Save current state to a default session before quitting',
--   callback = function()
--     if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 or vim.v.this_session ~= '' then
--       return
--     end
--     -- MiniSessions.write('LastSession.vim', { force = true })
--     MiniSessions.write(vim.fn.getcwd():gsub('[\\/:]', '%%') .. '.vim', { force = true })
--   end,
-- })
