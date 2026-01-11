vim.api.nvim_create_autocmd('FileType', {
  group = 'custom-config',
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions = 'jqlnM'
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'custom-config',
  callback = function()
    vim.hl.on_yank({ timeout = 80 })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'custom-config',
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if vim.fn.has('nvim-0.12') == 1 and client:supports_method('textDocument/documentColor') then
      vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
    end

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
  end
})
