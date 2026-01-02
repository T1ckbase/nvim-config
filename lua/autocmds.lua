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

-- vim.api.nvim_create_autocmd('InsertEnter', {
--   group = augroup,
--   callback = function()
--     vim.opt.relativenumber = false
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   group = augroup,
--   callback = function()
--     vim.opt.relativenumber = true
--   end,
-- })

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

-- vim.api.nvim_create_autocmd('CmdlineEnter', {
--   group = augroup,
--   callback = function()
--     vim.g.__saved_laststatus = vim.opt.laststatus:get()
--     vim.opt.laststatus = 0
--     vim.opt.cmdheight = 1
--   end,
-- })

-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--   group = augroup,
--   callback = function()
--     if vim.g.__saved_laststatus ~= nil then
--       vim.opt.laststatus = vim.g.__saved_laststatus
--       vim.g.__saved_laststatus = nil
--       vim.opt.cmdheight = 0
--     end
--   end,
-- })
