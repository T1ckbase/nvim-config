vim.lsp.config('denols', {
  settings = {
    deno = {
      suggest = {
        imports = {
          hosts = {
            ['https://deno.land'] = false
          }
        },
      },
    },
  },
  -- https://github.com/neovim/nvim-lspconfig/issues/3728#issuecomment-2966741537
  workspace_required = true,
  root_markers = { 'deno.json', 'deno.jsonc' },
  -- astronvim config
  -- root_dir = function(...) return require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')(...) end,
})
-- vim.lsp.config.denols.root_markers = { 'deno.json', 'deno.jsonc' }

vim.lsp.config('basedpyright', {
  cmd = { 'uvx', '--quiet', '--from', 'basedpyright', 'basedpyright-langserver', '--stdio' },
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'workspace',
        inlayHints = {
          callArgumentNames = false
        }
      },
    },
  }
})

vim.lsp.config('emmet_language_server', {
  cmd = { 'deno', 'run', '--quiet', '--no-lock', '--allow-all', 'npm:@olrtg/emmet-language-server', '--stdio' },
  cmd_env = { NO_COLOR = true }
})

vim.lsp.config('ruff', {
  cmd = { 'uvx', '--quiet', 'ruff', 'server' },
})

vim.lsp.config('pyrefly', {
  cmd = { 'uvx', '--quiet', 'pyrefly', 'lsp' }
})

vim.lsp.config('pyright', {
  cmd = { 'uvx', '--quiet', '--from', 'pyright', 'pyright-langserver', '--stdio' },
})

vim.lsp.config('ty', {
  cmd = { 'uvx', '--quiet', 'ty', 'server' },
})

vim.lsp.config('vtsls', {
  cmd = { 'deno', 'run', '--quiet', '--no-lock', '--allow-all', 'npm:@vtsls/language-server', '--stdio' },
  cmd_env = { NO_COLOR = true },
})

vim.lsp.enable({
  'lua_ls',
  'denols',
  -- 'basedpyright',
  'emmet_language_server',
  'ruff',
  'pyrefly',
  -- 'pyright',
  -- 'ty',
  'vtsls',
})

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'none',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    priority = 0,
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- if client:supports_method('textDocument/documentColor') then -- 0.12
    --   vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
    -- end

    -- format on save
    if not client:supports_method('textDocument/willSaveWaitUntil') and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false, id = args.data.client_id, timeout_ms = 5000 })
        end,
      })
    end
  end
})

-- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/typescript-all-in-one/init.lua
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('typescript_deno_switch', {}),
  callback = function(args)
    local bufnr = args.buf
    local curr_client = vim.lsp.get_client_by_id(args.data.client_id)

    if curr_client and curr_client.name == 'denols' then
      local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        name = 'vtsls',
      })
      for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id, true)
      end
    end

    -- if vtsls attached, stop it if there is a denols server attached
    if curr_client and curr_client.name == 'vtsls' then
      if next(vim.lsp.get_clients({ bufnr = bufnr, name = 'denols' })) then
        vim.lsp.stop_client(curr_client.id, true)
      end
    end
  end
})
