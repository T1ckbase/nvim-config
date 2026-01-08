vim.lsp.enable({
  'astro',
  'biome',
  'cssls',
  'denols',
  -- 'basedpyright',
  'emmet_language_server',
  'eslint',
  'html',
  'jsonls',
  'lua_ls',
  'markdown',
  'nushell',
  -- 'pyrefly',
  -- 'pyright',
  'ruff',
  'rust_analyzer',
  'svelte',
  -- 'stylua',
  'tsgo',
  'ty',
  -- 'vtsls',
  'zls'
})

vim.diagnostic.config({
  -- virtual_text = true,
  virtual_text = {
    severity = { min = 'INFO' }
  },
  -- underline = true,
  underline = {
    severity = {
      min = 'HINT',
      max = 'ERROR',
    }
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'none',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    priority = 0,
    severity = { min = 'INFO' },
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.INFO] = '󰋽',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
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

-- -- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/typescript-all-in-one/init.lua
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('typescript_deno_switch', {}),
--   callback = function(args)
--     local bufnr = args.buf
--     local curr_client = vim.lsp.get_client_by_id(args.data.client_id)

--     if curr_client and curr_client.name == 'denols' then
--       local clients = vim.lsp.get_clients({
--         bufnr = bufnr,
--         name = 'vtsls',
--       })
--       for _, client in ipairs(clients) do
--         vim.lsp.stop_client(client.id, false)
--       end
--     end

--     -- if vtsls attached, stop it if there is a denols server attached
--     if curr_client and curr_client.name == 'vtsls' then
--       if next(vim.lsp.get_clients({ bufnr = bufnr, name = 'denols' })) then
--         vim.lsp.stop_client(curr_client.id, false)
--       end
--     end
--   end
-- })
