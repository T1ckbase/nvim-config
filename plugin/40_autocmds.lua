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
        vim.notify(
          ('Trailing whitespace detected on line %d'):format(lnum),
          vim.log.levels.WARN,
          { title = 'Save warning' }
        )
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
  group = 'custom-config',
  pattern = { ':' }, -- { ':', '/', '?' },
  callback = function()
    vim.fn.wildtrigger()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'custom-config',
  callback = function()
    vim.opt_local.formatoptions = 'jqlnM'
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'custom-config',
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, { bufnr = args.buf }, { style = 'virtual' })
    end

    if client:supports_method('textDocument/inlineCompletion') then
      vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
    end

    -- if client:supports_method('textDocument/codeLens') then
    --   vim.lsp.codelens.enable(true, { bufnr = args.buf })
    -- end

    -- -- format on save
    -- if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('LspFormatOnSave', {}),
    --     buffer = args.buf,
    --     callback = function()
    --       if client.name == 'jsonls' then return end
    --       vim.lsp.buf.format({ async = false, id = args.data.client_id, timeout_ms = 5000 })
    --     end,
    --   })
    -- end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'custom-config',
  callback = function()
    vim.hl.on_yank({ timeout = 80 })
  end,
})
