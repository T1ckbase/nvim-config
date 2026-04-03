vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'custom-config',
  desc = 'Warn after saving if trailing whitespace exists',
  callback = function(args)
    local bufnr = args.buf

    -- Skip buffers where this is not useful.
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].binary or not vim.bo[bufnr].modifiable then
      return
    end

    -- Search only until the first match, without moving the cursor.
    vim.api.nvim_buf_call(bufnr, function()
      local lnum = vim.fn.search([[\s\+$]], 'nw')

      if lnum > 0 then
        vim.notify(('Trailing whitespace detected on line %d'):format(lnum), vim.log.levels.WARN, { title = 'Save warning' })
      end
    end)
  end,
})

-- vim.api.nvim_create_autocmd('CmdlineChanged', {
--   group = 'custom-config',
--   pattern = ':', -- { ':', '/', '?' },
--   callback = function()
--     vim.fn.wildtrigger()
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  group = 'custom-config',
  callback = function()
    -- vim.opt_local.formatoptions = 'jqlnM'
    vim.opt_local.formatoptions:remove({ 't', 'c', 'r', 'o' })
    vim.opt_local.formatoptions:append('M')
  end,
})

local format_group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = false })

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'custom-config',
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client.name ~= 'zls' and client.name ~= 'gopls' then
      return
    end

    if not client:supports_method('textDocument/formatting') then
      return
    end

    vim.api.nvim_clear_autocmds({
      group = format_group,
      buffer = args.buf,
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = format_group,
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          id = client.id,
          timeout_ms = 5000,
        })
      end,
    })
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  group = 'custom-config',
  callback = function(args)
    local name, kind = args.data.spec.name, args.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not args.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'custom-config',
  callback = function() vim.hl.on_yank({ timeout = 80 }) end,
})

vim.api.nvim_create_autocmd('User', {
  group = 'custom-config',
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set('n', '<C-s>', function()
      local entry = MiniFiles.get_fs_entry()
      if entry ~= nil and entry.fs_type == 'file' then
        MiniFiles.close()
        vim.cmd('split ' .. entry.path)
      end
    end, { buffer = buf_id, desc = 'Split horizontal' })

    vim.keymap.set('n', '<C-v>', function()
      local entry = MiniFiles.get_fs_entry()
      if entry ~= nil and entry.fs_type == 'file' then
        MiniFiles.close()
        vim.cmd('vsplit ' .. entry.path)
      end
    end, { buffer = buf_id, desc = 'Split vertical' })
  end,
})
